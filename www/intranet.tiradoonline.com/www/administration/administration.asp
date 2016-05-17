<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "administrationTheme"
	PageThemeColor = ADMINISTRATION_THEME
	PageTitle = "Control Panel"
	HeaderTitle = "Control Panel"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<!-- #include virtual="/includes/open_header.inc" -->


<div style="text-align:right">

<%= Button("Button", "Administration Home", "Button", "", "Administration Home", "location.href='" & SCRIPT_NAME & "'") %>
</div>
&nbsp;<br />
<table>
<tr valign="top">
	<td>

				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% ElseIf LCase(Template) = "email_templates" Then %>
					<!-- #include file="templates/email_templates.tem" -->
				<% ElseIf LCase(Template) = "profiler" Then %>
					<!-- #include file="templates/profiler.tem" -->
				<% ElseIf LCase(Template) = "logs" Then %>
					<!-- #include file="templates/logs.tem" -->
				<% ElseIf LCase(Template) = "backup" Then %>
					<!-- #include file="templates/backup.tem" -->
				<% ElseIf LCase(Template) = "schema" Then %>
					<!-- #include file="templates/schema.tem" -->
				<% ElseIf LCase(Template) = "sql" Then %>
					<!-- #include file="templates/sql.tem" -->
				<% ElseIf LCase(Template) = "reports" Then %>
					<!-- #include file="templates/reports.tem" -->
				<% ElseIf LCase(Template) = "users" Then %>
					<!-- #include file="templates/users.tem" -->
				<% ElseIf LCase(Template) = "pagelogs" Then %>
					<!-- #include file="templates/pagelogs.tem" -->
				<% End If %>

	</td>
	<!-- 
	***************************
	ADMINISTRATION RIGHT ICONS
	***************************
	 -->
	<% If Template <> "" Then %>
	<td width="100" valign="top">
		<!-- #include virtual="/administration/templates/home_sm.tem" -->
	</td>
	<% End If %>
</tr>
</table>
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
