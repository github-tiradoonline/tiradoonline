<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	test = 1
	PageTheme = "ServerTheme"
	PageThemeColor = SERVER_THEME
	PageTitle = "Servers"
	HeaderTitle = "Server Information"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%

	'Response.Write SubmitButton
	'Response.End
	SelectedTab = Trim(Request("SelectedTab"))
	ServerProjectID = Trim(Request("ServerProjectID"))
	ServerProjectName = Trim(Request("ServerProjectName"))
	ServerProjectNotes = Trim(Request("ServerProjectNotes"))
	
	ServerID = Trim(Request("ServerID"))
	ServerName = Trim(Request("ServerName"))
	ServerNotes = Trim(Request("ServerNotes"))
	
	ServerInformationID = Trim(Request("ServerInformationID"))
	ServerInformationOrderNum = Trim(Request("ServerInformationOrderNum"))
	ServerInformationName = Trim(Request("ServerInformationName"))
	ServerInformationValue = Trim(Request("ServerInformationValue"))
	OldOrderNumber = Trim(Request("OldOrderNumber"))
	NewOrderNumber = Trim(Request("NewOrderNumber"))
	
	'********************
	'	SERVER PROJECT
	'********************
	If SubmitButton = "CreateServerProject" Then
		sql = "sp_ServerProject_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(ServerProjectName) & "', " & _
			  "'" & SQLEncode(ServerProjectNotes) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		ServerProjectID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		
		If CStr(ServerProjectID) <> "0" Then
			ServerErrorMessage = Server.URLEncode("Server Project '" & ServerProjectName & "' added.")
			Response.Redirect SCRIPT_NAME & "?&ServerProjectID=" & ServerProjectID & "&SelectedTab=1&ServerErrorMessage=" & ServerErrorMessage
		Else
			ServerErrorMessage = Server.URLEncode("Server Project '" & ServerProjectName & "' exists.")
			Response.Redirect SCRIPT_NAME & "?&ServerProjectID=" & ServerProjectID & "&ServerErrorMessage=" & ServerErrorMessage
		End If
		
	ElseIf SubmitButton = "Save Server Project" Then
		sql = "UPDATE ServerProject SET " & _
			  "ServerProjectName = '" & SQLEncode(ServerProjectName) & "', " & _
			  "ServerProjectNotes = '" & SQLEncode(ServerProjectNotes) & "' " & _
			  "WHERE ServerProjectID = " & ServerProjectID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		
		ServerErrorMessage = Server.URLEncode("Server Project '" & ServerProjectName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?&ServerProjectID=" & ServerProjectID & "&ServerErrorMessage=" & ServerErrorMessage & "&SelectedTab=" & SelectedTab
	ElseIf SubmitButton = "DeleteServerProject" Then
		sql = "sp_ServerProject_delete " & ServerProjectID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ServerErrorMessage = Server.URLEncode("Project deleted.")
		Response.Redirect SCRIPT_NAME & "?ServerErrorMessage=" & ServerErrorMessage


	'********************
	'	SERVER
	'********************
	ElseIf SubmitButton = "Create Server" Then
		sql = "sp_Server_insert " & _
			  ServerProjectID & ", " & _
			  "'" & SQLEncode(ServerName) & "', " & _
			  "'" & SQLEncode(ServerNotes) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		ServerID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		If CStr(ServerID) <> "0" Then
			sql = "SELECT COUNT(*) FROM Server WHERE ServerProjectID = " & ServerProjectID
			Set ors = oConn.Execute(sql)
			TotalServers = ors.Fields(0).Value
			SelectedTab = CInt(TotalServers) + 1
			ServerErrorMessage = Server.URLEncode("Server '" & ServerName & "' added.")
			Response.Redirect SCRIPT_NAME & "?ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID & "&SelectedTab=" & SelectedTab & "&ServerErrorMessage=" & ServerErrorMessage
		Else
			ServerErrorMessage = Server.URLEncode("Server '" & ServerName & "' exists.")
			Response.Redirect SCRIPT_NAME & "?ServerProjectID=" & ServerProjectID & "&ServerErrorMessage=" & ServerErrorMessage
		End If
	ElseIf SubmitButton = "Save Server" Then
		sql = "UPDATE Server SET " & _
			  "ServerName = '" & SQLEncode(ServerName) & "', " & _
			  "ServerNotes = '" & SQLEncode(ServerNotes) & "' " & _
			  "WHERE ServerID = " & ServerID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		
		ServerErrorMessage = Server.URLEncode("Server Information '" & ServerName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID & "&SelectedTab=" & SelectedTab & "&ServerErrorMessage=" & ServerErrorMessage
	ElseIf SubmitButton = "DeleteServer" Then
		sql = "sp_Server_delete " & ServerID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ServerErrorMessage = Server.URLEncode("Server deleted.")
		Response.Redirect SCRIPT_NAME & "?ServerErrorMessage=" & ServerErrorMessage & "&SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID



	'********************
	'	SERVER INFORMATION
	'********************
	ElseIf SubmitButton = "Create Server Information" Then
		sql = "sp_ServerInformation_insert " & _
			  ServerID & ", " & _
			  "'" & SQLEncode(ServerInformationName) & "', " & _
			  "'" & SQLEncode(ServerInformationValue) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		ServerInformationID = ors.Fields(0).Value
		If CStr(ServerInformationID) <> "0" Then
			ServerErrorMessage = Server.URLEncode("Server Information added.")
			Response.Redirect SCRIPT_NAME & "?SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID
		Else
			ServerErrorMessage = Server.URLEncode("Server Information exists.")
			Response.Redirect SCRIPT_NAME & "?ServerErrorMessage=" & ServerErrorMessage & "&SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID
		End If
	ElseIf SubmitButton = "Save Server Information" Then
		sql = "UPDATE ServerInformation SET " & _
			  "ServerInformationName = '" & SQLEncode(ServerInformationName) & "', " & _
			  "ServerInformationValue = '" & SQLEncode(ServerInformationValue) & "' " & _
			  "WHERE ServerInformationID = " & ServerInformationID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ServerErrorMessage = Server.URLEncode("Server Information saved.")
		Response.Redirect SCRIPT_NAME & "?&Action=ServerInformation&ServerInformationID=" & ServerInformationID & "&ServerErrorMessage=" & ServerErrorMessage & "&SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID
	ElseIf SubmitButton = "ServerInformationOrderChangeServer" Then
		sql = "sp_ServerInformation_ServerInformationOrderNum " & _
			ServerInformationID & ", " & _
			ServerID & ", " & _
			OldOrderNumber & ", " & _
			NewOrderNumber
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ServerErrorMessage = Server.URLEncode("Server Information changed.")
		Response.Redirect SCRIPT_NAME & "?SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID & "&ServerErrorMessage=" & ServerErrorMessage
	ElseIf SubmitButton = "DeleteServerInformation" Then
		sql = "sp_ServerInformation_delete " & _
			ServerInformationID & ", " & _
			ServerID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ServerErrorMessage = Server.URLEncode("Server Information deleted.")
		Response.Redirect SCRIPT_NAME & "?ServerErrorMessage=" & ServerErrorMessage & "&SelectedTab=" & SelectedTab & "&ServerProjectID=" & ServerProjectID & "&ServerID=" & ServerID
	End If

	'Response.Write SubmitButton
	'Response.End
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<form action="<%= SCRIPT_NAME %>" method="post">
				<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
				<tr>
					<td class="frm_label" align="right"><b>&nbsp;&nbsp;&nbsp;Server&nbsp;&nbsp;Project&nbsp;Name:</b></font>&nbsp;</td>
					<td>
						<%= formTextBox("ServerProject_Name", "40", "", "ServerElement", "Server Project Name", "Invalid Server Project Name") %><%= REQUIRED_ICON %>
					</td>
				</tr>
				<tr>
					<td class="frm_label" valign="top">Notes:</td>
					<td>
						<%= formTextArea("Server_Notes", ServerNotes, "400", "100", "ServerElement", "Description", "Invalid Description") %>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff">
						<tr valign=top>
							<td>
								<%= Button("Button", "Create Project", "Button", "", "Create Server", "formServerProjectCreate()") %>
							</td>
							<td>
								<%= Button("Button", "View All Server Projects", "Button", "", "", "location.href='" & SCRIPT_NAME & "?Information'") %>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				</form>
				&nbsp;<br />
				<% If ServerErrorMessage <> "" Then %>
				<div class="ErrorMessage"><%= ServerErrorMessage %></div>
				&nbsp;<br />
				<% End If %>
				<!-- #include file="templates/servers.tem" -->
				


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->