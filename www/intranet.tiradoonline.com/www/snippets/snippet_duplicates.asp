<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "SnippetsTheme"
	PageThemeColor = SNIPPETS_THEME
	PageTitle = "Snippets"
	HeaderTitle = "Snippets"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	SnippetID = Trim(Request("SnippetID"))

	If SubmitButton = "DeleteSnippet" Then
		sql = "DELETE FROM Snippets WHERE SnippetID = " & SnippetID
		oConn.Execute sql
		SnippetsErrorMessage = Server.URLEncode("Snippet " & SnippetID & " deleted.")
		Response.Redirect SCRIPT_NAME & "?SnippetsErrorMessage=" & SnippetsErrorMessage
	End If		
%>
<!-- #include virtual="/includes/open_header.inc" -->

<% If SnippetsErrorMessage <> "" Then %>
<div class="ErrorMessage"><%= SnippetsErrorMessage %></div>
<p />
<% End If %>


<% If SnippetID = "" Then %>
<form action="<%= SCRIPT_NAME %>" method="post">
<table>
<%
	sql = "SELECT b.SnippetID, a.SnippetGroupName, b.SnippetName FROM SnippetGroups a, Snippets b WHERE a.SnippetGroupID = b.SnippetGroupID ORDER BY a.SnippetGroupName, b.SnippetName"
	Set ors = oConn.Execute(sql)
	
	Do Until ors.EOF
		SnippetID = ors("SnippetID")
		SnippetGroupName = ors("SnippetGroupName")
		SnippetName = ors("SnippetName")
%>
<tr>
	<td><%= SnippetGroupName %></td>
	<td><a href="<%= SCRIPT_NAME %>?SnippetID=<%= SnippetID %>"><%= SnippetName %></a></td>
	<td><input type="button" id="SubmitButton" name="SubmitButton" class="Button" value="Delete" onclick="location.href='<%= SCRIPT_NAME %>?SubmitButton=DeleteSnippet&SnippetID=<%= SnippetID %>'" /></td>
</tr>

<%
		ors.MoveNext
	Loop
	ors.Close
	
	Set ors = Nothing
%>
</table>
</form>	

<% Else %>

<%
	sql = "SELECT Snippet FROM Snippets WHERE SnippetID = " & SnippetID
	Set ors = oConn.Execute(sql)
	SnippetText = ors.Fields(0).Value
	ors.Close
	Set ors = Nothing
	
	
%>

<%= HTMLFormat2(SnippetText) %>
<% End If %>
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
