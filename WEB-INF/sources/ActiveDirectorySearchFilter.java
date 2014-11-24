package com.searchblox.search;

import static org.apache.shiro.SecurityUtils.getSubject;

import java.io.IOException;
import java.io.Writer;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.subject.Subject;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonWriter;

public class ActiveDirectorySearchFilter implements Filter {

	@Override
	public void init(final FilterConfig filterConfig) throws ServletException {
		// no code in here
	}

	@Override
	public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
		if (getSubject() == null || !getSubject().isAuthenticated()) {
			// if there is no subject or it is not authorized - proceed as usual
			chain.doFilter(request, response);
		} else {
			// we have Active Directory subject here, so intercepting response from SearchServlet here
			final ResponseCapturingWrapper httpResponse = new ResponseCapturingWrapper((HttpServletResponse) response);
			chain.doFilter(request, httpResponse);

			// retrieving JSONP response and getting JSON out of it
			final String jsonp = new String(httpResponse.getCopy(), httpResponse.getCharacterEncoding());
			final String json = jsonp.substring(jsonp.indexOf("(") + 1, jsonp.lastIndexOf(")"));

			// filtering JSON results and writing it as JSONP to response
			@SuppressWarnings("resource")
			final Writer outputWriter = ((HttpServletResponse) response).getWriter();
			outputWriter.write(jsonp.substring(0, jsonp.indexOf("(") + 1));
			filterAndWriteResults(json, outputWriter, getSubject());
			outputWriter.write(")");
		}
	}

	@Override
	public void destroy() {
		// no code in here
	}

	private static void filterAndWriteResults(final String json, final Writer outputWriter, final Subject subject) {
		try {
			// we should not close JsonWriter since it will automatically close underlying writer which is incorrect
			@SuppressWarnings("resource")
			final JsonWriter writer = new JsonWriter(outputWriter);
			final Gson gson = new Gson();

			writer.beginObject();
			final JsonObject obj = new JsonParser().parse(json).getAsJsonObject();
			for (final Entry<String, JsonElement> entry : obj.entrySet()) {
				if ("results".equals(entry.getKey())) {
					// parsing "results" element and going into it since it contains result to be filtered based on AD user role
					final JsonObject resultsObject = entry.getValue().getAsJsonObject();
					filterResultsObject(resultsObject, writer, subject, gson);
				} else {
					writer.name(entry.getKey());
					gson.toJson(entry.getValue(), writer);
				}
			}

			writer.endObject();
		} catch (final IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	private static void filterResultsObject(final JsonObject resultsObject, final JsonWriter writer, final Subject subject, final Gson gson)
			throws IOException {
		writer.name("results");
		writer.beginObject();
		for (final Entry<String, JsonElement> entry : resultsObject.entrySet()) {
			if ("result".equals(entry.getKey())) {
				// parsing "result" array and filtering it based on AD user role
				final JsonArray resultArray = entry.getValue().getAsJsonArray();
				handleResultArray(resultArray, writer, subject, gson);
			} else {
				writer.name(entry.getKey());
				gson.toJson(entry.getValue(), writer);
			}
		}
		writer.endObject();
	}

	private static void handleResultArray(final JsonArray resultArray, final JsonWriter writer, final Subject subject, final Gson gson)
			throws IOException {
		writer.name("result");
		writer.beginArray();
		for (final JsonElement element : resultArray) {
			final JsonObject resultObject = element.getAsJsonObject();
			if (hasReadAccess(resultObject, subject)) {
				gson.toJson(resultObject, writer);
			}
		}
		writer.endArray();
	}

	private static boolean hasReadAccess(final JsonObject resultObject, final Subject subject) {
		for (final Entry<String, JsonElement> entry : resultObject.entrySet()) {
			final String propertyName = entry.getKey();
			if (propertyName.endsWith("_ALLOW")) {
				try {
					final String aclList = entry.getValue().getAsString();
					if (aclList != null && (aclList.contains("READ_DATA,") || aclList.contains("READ_DATA]"))) {
						final String roleName = propertyName.substring(0, propertyName.length() - "_ALLOW".length());
						if (subject.hasRole(roleName)) {
							return true;
						}
					}
				} catch (final Exception ex) {
					continue;
				}
			}
		}
		return false;
	}

	public static void main(final String[] args) {
		final String jsonp = "jQuery17102842377470806241_1416566182250({\"results\":{}})";
		System.out.println(jsonp.substring(0, jsonp.indexOf("(") + 1));
	}

}