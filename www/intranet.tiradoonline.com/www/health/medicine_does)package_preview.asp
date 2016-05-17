<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->
<%
	PageTheme = "healthTheme"
	PageThemeColor = HEALTH_THEME
	PageTitle = "Health"
	HeaderTitle = "Health"
	Response.Buffer = true

	MedicineDosePackageID = Trim(Request("MedicineDosePackageID"))
	
	sql = "SELECT * FROM MedicineDosePackage WHERE MedicineDosePackageID = " & MedicineDosePackageID
	WriteDebugger sql, Debugging, 0
	Set ors = oConn.Execute(sql)
	MedicineDosePackageName = ors("MedicineDosePackageName")
	ors.Close
	Set ors = Nothing
	
%>


<!-- #include virtual="/includes/functions.inc" -->
<html>
<head>
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">
	<link rel="icon" type="image/ico" href="/images/icons/logo.ico" /> 
	<link rel="shortcut icon" href="/images/icons/logo.ico" />
	<!-- #include virtual="/includes/css/global.css" -->

	<title><%= PageTitle %>: <%= MedicineDosePackageName %></title>
</head>

<body>

<h1 style="text-align:center;"><%= MedicineDosePackageName %></h1>
<table class="GridViewAlteringRows" width="100%">
<tr class="HealthTheme" valign="top"">
	<td style="font-size:15px;" width="100%">Medicine</td>
	<td style="font-size:15px;" align="right">Dosage</td>
	<td style="font-size:15px;">Description</td>
</tr>
<%
		sql = "sp_MedicineDosePackage_MedicineDosePackageID_get " & MedicineDosePackageID
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		Do Until ors.EOF
			Medicine = ors("Medicine")
			Amount = ors("Amount")
			Description = ors("Description")
			Unit = ors("Unit")
%>
<tr class="GridViewRow" valign="top">
	<td style="font-size:15px;"><b><%= Medicine %></b></td>
	<td style="font-size:15px;" align="right"><%= Amount %>&nbsp;<%= Unit %></td>
	<td style="font-size:15px;"><%= Description %></td>
</tr>

<%
			ors.MoveNext
		Loop
		ors.Close
%>
</table>


</body>
</html>


<!-- #include virtual="/includes/close_connection.inc" -->
