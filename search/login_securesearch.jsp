<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<html>
<head>


	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Font Awesome CSS -->
    <link href="../admin/new_Styles/fonts/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="../admin/new_Styles/css/bootstrap.css" rel="stylesheet" media="screen">
    <!-- TableTools CSS -->
    <link href="../admin/Bootstrap/tabletools/css/TableTools.css" rel="stylesheet" media="screen">
    <!-- Main CSS -->
    <link href="../admin/new_Styles/css/main.css" rel="stylesheet" media="screen">
    <!-- Collection Dashboard Style CSS -->
    <link href="../styles_dashboard.css" rel="stylesheet" media="screen">

<style type="text/css">
table.sample {
	border-width: 1px;
	border-style: outset;
	border-color: blue;
	border-collapse: separate;
	background-color: rgb(255, 255, 240);
}

table.sample th {
	border-width: 1px;
	padding: 1px;
	border-style: none;
	border-color: blue;
	background-color: rgb(255, 255, 240);
}

table.sample td {
	border-width: 1px;
	padding: 1px;
	border-style: none;
	border-color: blue;
	background-color: rgb(255, 255, 240);
}
</style>
</head>
<body>

	<div class="container">
	
		<div class="top-bar" style="margin-bottom: 40px;">

			<i class="logo-searchblox">
				<img alt="" src="../images/logo-searchblox.gif">
			</i>

			<ul id="icon-nav">
				<li><a href="https://searchblox.atlassian.net/wiki/display/SD/SearchBlox+User%27s+Guide"><i class="icon- icon-info-sign"></i></a></li>
				<li><a href="http://www.searchblox.com"><i class="icon-envelope-alt"></i></a></li>
			</ul>

		</div>
		
		<div class="panel panel-default">
				<div class="panel-heading clearfix">
              		<h3 class="panel-title">Please Log in using Active Directory credentials</h3>
            	</div>

					<p style="margin: 15px 0 0 20px;">Before using this page please <b>make sure</b> that <b>SearchBlox</b> is correctly <b>configured</b> by Administrator for use <b>with Active Directory</b></p>
					<p style="margin: 15px 0 20px 20px;"><b>Please remember</b> to use login name with domain name like <b>john@company.com</b> (not simply <b>john</b>)</p>
						
					<form name="loginform" action="" method="post" class="form-horizontal">
						<table style="margin-left:20px;">
							<tr>
								<td>Username:</td>
								<td><input type="text" name="username" maxlength="30" style="height:30px;" class="form-control"></td>
							</tr>
							<tr><td style="height: 10px;"></td></tr>
							<tr>
								<td>Password:</td>
								<td><input type="password" name="password" maxlength="30" style="height:30px;" class="form-control"></td>
							</tr>
							<tr><td style="height: 10px;"></td></tr>
							<tr>
								<td colspan="2" align="left"><input type="checkbox"
									name="rememberMe" ><font size="2"> Remember Me</font></td>
							</tr>
							<tr><td style="height: 10px;"></td></tr>
							<tr>
								<td colspan="2" align="center"><input type="submit" name="submit" value="Login" class="btn btn-primary" ></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		<div class="row-fluid">
			<footer>
			<p>
				<span class="copyright">Copyright &copy; 2014 SearchBlox
					Software, Inc.</span>
			</p>


			</footer>
		</div>

</body>
</html>
