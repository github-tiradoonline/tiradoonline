<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "healthTheme"
	PageThemeColor = HEALTH_THEME
	PageTitle = "Health"
	HeaderTitle = "Health"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	MediaFileName = Trim(Request("MediaFileName"))
%>

<!-- #include virtual="/includes/open_header.inc" -->


<table>
<tr valign="top">
	<td>
		<!-- #include file="templates/media.tem" -->
	</td>
</tr>
</table>


<!-- #include virtual="/includes/debug.inc" -->
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
