<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->

<%
	Width = 700
	Height = 15
	If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
		'Response.ContentType = "application/json"	
		sql = Trim(Request("sql"))
		'sql = "sp_users_username_password 'teddy', 'sixpak'"
		'sql = "SELECT * FROM USERS where username like"
		If sql <> "" Then
			Set ors = oConn.Execute(sql)
	
			If NOT ors.EOF Then
				JSONResults = ConvertToJSON(ors, "SQL")
			'ors.MoveFirst
				ors.Close
			Set ors = Nothing
			End If
		End If
	End If
%>

<form action="<%= SCRIPT_NAME %>" method="post">
<button type="submit" style="text-align:right">EXECUTE</button>
<textarea id="sql" name="sql" cols="<%= Width %>" rows="<%= Height %>">
<%= sql %>
</textarea>
<p />
<textarea id="JSONResults" name="JSONResults" cols="<%= Width %>" rows="<%= Height %>">
<%= JSONResults %>
</textarea>

</form>	
<!-- #include virtual="/includes/close_connection.inc" -->
