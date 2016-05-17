<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "SettingsTheme"
	PageThemeColor = SETTINGS_THEME
	PageTitle = "Settings"
	HeaderTitle = "Settings"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
%>


<!-- #include virtual="/includes/open_header.inc" -->


				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% ElseIf Template = "settings" Then %>
				<!-- #include file="templates/settings.tem" -->
				<% End If %>

<%= formHidden("Template", Template) %>


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
