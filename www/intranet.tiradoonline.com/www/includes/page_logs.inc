<%
	If InStr(SCRIPT_NAME, "default.asp") = 0 Then
		vForm = ""
		vQueryString = ""
		vQueryString2 = ""
		CounterItem = "?"
		For Each Item In Request.QueryString
	   		vQueryString = vQueryString & Item & "=" & SQLEncode(Request.QueryString(Item)) & "|||||"
			
	   		vQueryString2 = vQueryString2 & CounterItem & Item & "=" & Server.URLEncode(Request.QueryString(Item))
			CounterItem = "&"
		Next
		vPreviousPage = SCRIPT_NAME & vQueryString2
		If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
			For Each Item In Request.Form
		   		vForm = vForm & Item & "=" & SQLEncode(Upload.Form(Item)) & "|||||"
			Next
		Else
			For Each Item In Request.Form
		   		vForm = vForm & Item & "=" & SQLEncode(Request.Form(Item)) & "|||||"
			Next
		End If
		
		vUserID = Session("UserID")
		If vUserID = "" Then vUserID = Session.SessionID
		sql = "sp_PageLogs_insert " & _
				 	vUserID & ", " & _
				 	"'" & SQLEncode(SCRIPT_NAME) & "', " & _
				 	"'" & SQLEncode(Request.ServerVariables("REQUEST_METHOD")) & "', " & _
				 	"'" & SQLEncode(Template) & "', " & _
				 	"'" & SQLEncode(Action) & "', " & _
				 	"'" & SQLEncode(vQueryString) & "', " & _
				 	"'" & SQLEncode(vForm) & "', " & _
				 	"'" & SQLEncode(vPreviousPage) & "'"
		'Response.Write sql
		WriteDebugger sql, Debugging, 0
		Set orsPageLog = oConn.Execute(sql)
		PageLogID = orsPageLog.Fields(0).Value
		orsPageLog.Close
		Set orsPageLog = Nothing
	End If
%>