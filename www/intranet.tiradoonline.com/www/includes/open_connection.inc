<%
	Set oConn = Server.CreateObject("ADODB.Connection")
	ConnectionString = "driver={SQL SERVER};server=" & MachineName & ";uid=tiradoonline_user;pwd=Sixpak141414;database=tiradoonline;"
	'Response.Write ConnectionString
	'Response.End	
	'On Error Resume Next
	oConn.ConnectionTimeout = 10
	oConn.Open ConnectionString
	
	'If Instr(UCase(Request.ServerVariables("HTTP_USER_AGENT")), "MOZILLA") = 0 AND Instr(UCase(Request.ServerVariables("HTTP_USER_AGENT")), "MOZILLA") = 0 Then
	'	isMobile = true
	'Else
	'	isMobile = false
	'End If


	If Session("UserID") <> "" Then
		sql = "sp_Settings_get " & Session("UserID")
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			Debugging = ors("DebuggingSetting")
			Documents_Directory = ors("DocumentsDirectory")
			Photos_Directory = ors("PhotosDirectory")
			Music_Directory = ors("MusicDirectory")
			Movies_Directory = ors("MoviesDirectory")
			ors.Close
		End If
		Set ors = Nothing
	End If
%>