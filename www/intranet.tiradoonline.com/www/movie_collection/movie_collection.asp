<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "MovieCollectionTheme" 
	PageThemeColor = MOVIE_COLLECTION_THEME
	PageTitle = "Movie Collection"
	HeaderTitle = "Movie Collection"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<!-- #include virtual="/includes/open_header.inc" -->

				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% End If %>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
