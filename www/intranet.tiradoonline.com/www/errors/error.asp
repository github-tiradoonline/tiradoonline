<!-- #include virtual="/includes/globals.inc" -->

<%
	ErrorNumber = Trim(Request("ErrorNumber"))
	ErrorDescription = Trim(Request("ErrorDescription"))
	
	Title = "Bankingintranet.tiradoonline.com - ERROR"
	
%>
<html>
<head>
    <title><%= Title %></title>
	<link rel="icon" type="image/ico" href="/images/icons/logo.ico" /> 
	<link rel="shortcut icon" href="/images/icons/logo.ico" />
	<!-- #include virtual="/includes/css/global.css" -->
</head>

<body>
	
<div id="LoginBoxLogin" class="shadow" style="display:block;width:800px">
<table cellspacing=0 cellpadding=3 border=0 bgcolor="#ff0000">
<tr>
	<td>
		<table cellspacing=0 cellpadding=2 border=0 bgcolor=#ffffff>
		<tr>
			<td colspan="3" bgcolor="#ff0000" align=center>&nbsp;&nbsp;&nbsp;<font color=#ffffff face="Verdana"><b><%= UCase(Title) %></b></font>&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td>
				<%= LOGO %>
			</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td align=center valign="middle">
	
				<table>
				<tr valign="top">
					<td class="frm_label">Error#:</td>
					<td><%= ErrorNumber %></td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td class="frm_label">Description:</td>
					<td><%= ErrorDescription %></td>
				</tr>
				</table>
				
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</div>

