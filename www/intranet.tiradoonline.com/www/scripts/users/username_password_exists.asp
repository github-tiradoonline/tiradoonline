<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->
<%
	UserName = Trim(Request("UserName"))
	Password = Trim(Request("Password"))
	
	'sql = "sp_Users_UserName_Password '" & SQLEncode(UserName) & "', '" & SQLEncode(Password) & "'"
	sql = "SELECT * FROM Users"
	Set ors = oConn.Execute(sql)
	
	
	If ors.EOF Then
		'Response.Write "0"
		ors.Close
	Else
		Response.Write "<pre>" & ConvertToJSON(ors, "Users") & "</pre>"
		'Response.Write "1"
	End If
	Set ors = Nothing
%>
<!-- #include virtual="/includes/close_connection.inc" -->