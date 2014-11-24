package com.searchblox.search;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.ServletOutputStream;

public class ServletOutputStreamCopier extends ServletOutputStream {

	private final ByteArrayOutputStream copy;

	public ServletOutputStreamCopier() {
		this.copy = new ByteArrayOutputStream();
	}

	@Override
	public void write(final int b) throws IOException {
		copy.write(b);
	}

	public byte[] getCopy() {
		return copy.toByteArray();
	}

}
