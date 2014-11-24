<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>SearchBlox : Faceted Search</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Font Awesome CSS -->
    <link href="../../admin/new_Styles/fonts/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="../../admin/new_Styles/css/bootstrap.css" rel="stylesheet" media="screen">
    <!-- TableTools CSS -->
    <link href="../../admin/Bootstrap/tabletools/css/TableTools.css" rel="stylesheet" media="screen">
    <!-- Main CSS -->
    <link href="../../admin/new_Styles/css/main.css" rel="stylesheet" media="screen">
    <!-- Collection Dashboard Style CSS -->
    <link href="../../styles_dashboard.css" rel="stylesheet" media="screen">

<script type="text/javascript"
	src="/searchblox/plugin/vendor/json2extension.js"></script>
<script type="text/javascript"
	src="/searchblox/plugin/vendor/jquery/1.7.1/jquery-1.7.1.min.js"></script>

<script type="text/javascript"
	src="/searchblox/plugin/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="/searchblox/plugin/vendor/bootstrap/js/bootstrap-typeahead.js"></script>

<script type="text/javascript"
	src="/searchblox/plugin/vendor/linkify/1.0/jquery.linkify-1.0-min.js"></script>	
<script type="text/javascript"
	src="/searchblox/plugin/vendor/jquery-ui-1.8.18.custom/jquery-ui-1.8.18.custom.min.js"></script>

<script type="text/javascript"
	src="/searchblox/plugin/jquery.facetview.js"></script>

<script type="text/javascript" src="/searchblox/plugin/vendor/moment.js"></script>
<script type="text/javascript" src="/searchblox/plugin/vendor/cookie.js"></script>
<script type="text/javascript"
	src="/searchblox/plugin/vendor/jquery.prettyPhoto.js"></script>
<script type="text/javascript"
	src="/searchblox/plugin/vendor/tagcloud/jquery.tagcloud.js"></script>
<script type="text/javascript">
	if (typeof String.prototype.startsWith != 'function') {
		String.prototype.startsWith = function(str) {
			return this.slice(0, str.length) == str;
		};
	}

	if (typeof String.prototype.trim != 'function') {
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g, '');
		};
	}

	if (typeof String.prototype.splitOnFirst != 'function') {
		String.prototype.splitOnFirst = function(str) {
			var d = this.indexOf(str);
			if (0 > d)
				return this;
			else {
				return [ this.substr(0, d), this.substr(d + str.length) ];
			}
		};
	}

	function shuffle(items) {
		var cached = items.slice(0), temp, i = cached.length, rand;
		while (--i) {
			rand = Math.floor(i * Math.random());
			temp = cached[rand];
			cached[rand] = cached[i];
			cached[i] = temp;
		}
		return cached;
	}
	function shuffleNodes(list) {
		var nodes = list.children, i = 0;
		nodes = toArray(nodes);
		nodes = shuffle(nodes);
		while (i < nodes.length) {
			list.appendChild(nodes[i]);
			++i;
		}
	}

	function toArray(obj) {
		var array = [];
		// iterate backwards ensuring that length is an UInt32
		for ( var i = obj.length >>> 0; i--;) {
			array[i] = obj[i];
		}
		console.log(array)
		return array;
	}

	jQuery(document).ready(function($) {
		$('.facet-view-simple').facetview({
			search_url : '../../servlet/SearchServlet?',
			search_index : 'searchblox',
			facets : [
			//{'field': 'language', 'display': 'Language'},
			//{'field': 'title', 'display': 'Headlines'},
			{
				'field' : 'generator',
				'display' : 'Meta'
			}, {
				'field' : 'contenttype',
				'display' : 'File Type'
			}, {
				'field' : 'keywords',
				'display' : 'Keywords'
			}, {
				'field' : 'colname',
				'display' : 'Collection'
			}, ]
		});

	});
</script>



<style type="text/css">
.facet-view-simple {
	width: 900px;
	height: auto;
	margin: 5px auto 0 auto;
}
</style>

</head>

	<div class="container" style="vertical-align: middle">
		<div class="header" align="center"
			style="margin-top: 100px; padding: 5px">

			<p>
				Hi
				<shiro:guest>Guest</shiro:guest>
				<shiro:user>
					<shiro:principal />
				</shiro:user>
				! (
				<shiro:user>
					<a href="logout.jsp">Log out</a>
				</shiro:user>
				<shiro:guest>
					<a href="/searchblox/search/login_securesearch.jsp">Log in</a> (sample accounts provided)</shiro:guest>
				)
			</p>

			<a href="http://www.searchblox.com">
				<img src="/searchblox/plugin/images/tm-logo-searchblox.gif" />
			</a>
		</div>
		<div class="facet-view-simple"></div>
	</div>
	<div id="footer" style="height: 4em" align="center">
		<span class="copyright">Copyright 2014 SearchBlox Software, Inc.</span>
		<span class="links">&nbsp;<a href="http://www.searchblox.com" target="_blank">Contact Us</a>&nbsp;|&nbsp;
			<a href="/searchblox/">Open search</a>
		</span>
	</div>
</body>
</html>
