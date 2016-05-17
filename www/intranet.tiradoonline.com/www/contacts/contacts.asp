<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<% 
	PageTheme = "contactsTheme" 
	PageThemeColor = CONTACTS_THEME
	PageTitle = "Contacts"
	HeaderTitle = "Contacts"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<!-- #include virtual="/includes/open_header.inc" -->


<% If Template = "" Then %>
	<!-- #include file="templates/home.tem" -->
<% ElseIf Template = "View" Then %>
	<!-- #include file="templates/contacts.tem" -->
<% End If %>

	
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
