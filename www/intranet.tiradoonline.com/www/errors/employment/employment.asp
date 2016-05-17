<%
	PageTitle = "Employment"
	HeaderTitle = "Employment"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<html>
<head>
	<title>Employment: <%= Session("FullName") %></title>
	<link rel="stylesheet" type="text/css" href="/styles/css/global.css">
	<!-- #include virtual="/includes/functions.js" -->
	<link href="/includes/jquery/jquery.css" rel="stylesheet">
	<link href="/includes/jquery/jquery.css" rel="stylesheet">
	<script src="/includes/jquery/jquery.js"></script>
	<script src="/includes/jquery/jquery-ui.js"></script>
</head>
<body bgcolor="#ffffff" link="#0000ff" alink="#0000ff" vlink="#0000ff" onLoad="SetDateTime()">
<table cellspacing=0 cellpadding=0 border=0 height="100%" align="left" width="120">
<tr>
	<td align=right valign=top>
		<!-- #include virtual="/includes/navigation.inc" -->
	</td>
</tr>
</table>
<table cellspacing=0 cellpadding=0 border=0 height="100%" width="680">
<tr>
	<td width="100%" valign=top>
		<table cellspacing=1 cellpadding=0 width="100%" border=0>
		<tr>
			<td bgcolor="#0000aa">
				<table cellspacing=0 cellpadding=0 border=0 width="100%">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;<font face="Verdana,Arial" size=2 color="#639AFF"><b>Employment:</b></font>&nbsp;&nbsp;<font face="Verdana,Arial" size=2 color="#ffffff"><b><%= Session("FullName") %></b></td>
					<td align="right"><span id="TodaysDate" style="font-family:Verdana;font-size:10pt;font-weight:bold;color:white;position:relative;"></span>&nbsp;&nbsp;&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td bgcolor="#000066">
				<% If Template = "" Then %>
					<table cellspacing=0 cellpadding=0 width="100%" border=0 bgcolor="#ffffff">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td width="100%">
							&nbsp;<br />
							&nbsp;<br />
							<font face="Verdana,Arial" size=2>
							<li><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?Template=Companies">Companies</a>
							<p>
							<%
								sql = "sp_Companies_UserID " & Session("UserID")
								Set ors = oConn.Execute(sql)
								If NOT ors.EOF Then
							%>
							<li><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?Template=Timesheets">Timesheets</a>
							<p>
							<li><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?Template=Paychecks">Paychecks</a>
							<p>
							<li><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?Template=PersonalDays">Personal&nbsp;days</a>
							<p>
							<li><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?Template=SickDays">Sick&nbsp;days</a>
							<%
								End If
								ors.Close
								Set ors = Nothing
							%>
						</td>
					</tr>
					</table>
				<% ElseIf LCase(Template) = "companies" Then %>
					<!-- #include file="templates/companies.tem" -->
				<% ElseIf LCase(Template) = "timesheets" Then %>
					<!-- #include file="templates/timesheet.tem" -->
				<% ElseIf LCase(Template) = "paychecks" Then %>
					<!-- #include file="templates/paychecks.tem" -->
				<% ElseIf LCase(Template) = "sickdays" Then %>
					<!-- #include file="templates/sickdays.tem" -->
				<% ElseIf LCase(Template) = "personaldays" Then %>
					<!-- #include file="templates/personaldays.tem" -->
				<% End If %>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</body>
</html>
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
