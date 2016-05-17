<%
	Debugging = false
	'Response.Write(Request.Header("http_user_agent"))
	'Response.Write(Request.ServerVariables("http_user_agent"))
		'Response.Write "Session(""UserID""):" & Session("Administrator")		
	
	If Instr(UCase(Request.ServerVariables("SCRIPT_NAME")), "DEFAULT.ASP") = 0 Then
		
		If Trim(Session("Administrator")) = "" Then 
		
			Response.Redirect Application("DefaultFile") & "?LoginErrorMessage=" & Server.URLEncode("Your session has timed out.")
			If isMobile Then 
				Response.Redirect "/default.asp?LoginErrorMessage=" & Server.URLEncode("Your session has timed out.")
			End If

			'Response.Write "<script language=""JavaScript"">" & vbCrLF
			'Response.Write "<!--" & vbCrLF
			'Response.Write "	location.href = ""/default.asp?ErrorMessage=" & Server.URLEncode("Your session has timed out.") & """;" & vbCrLF
			'Response.Write "//-->" & vbCrLF
			'Response.Write "</script>" & vbCrLF
		End If
	End If
%>