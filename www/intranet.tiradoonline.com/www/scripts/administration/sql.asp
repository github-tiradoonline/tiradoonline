<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->

<%
	Response.ContentType = "application/json"	
	'If UCase(Request.ServerVariables("REQUEST_METHOD")) = "POST" Then
		sql = Trim(Request("sql"))
		If sql <> "" Then
			Set ors = oConn.Execute(sql)
	
			If NOT ors.EOF Then
				Response.Write ConvertToJSON(ors, "SQL")
				'ors.MoveFirst
				ors.Close
			Set ors = Nothing
			End If
		End If
	'End If
%>
<!-- #include virtual="/includes/close_connection.inc" -->
