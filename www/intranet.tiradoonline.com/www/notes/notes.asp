<%
	PageTheme = "NotesTheme"
	PageTitle = "Notes"
	HeaderTitle = "Notes"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	NoteID = Trim(Request("NoteID"))
	NoteName = Trim(Request("NoteName"))
	NoteText = Trim(Request("NoteText"))

	'***************************************************'
	'******************* NOTES *****************'
	'***************************************************'
	If SubmitButton = "Create Note" Then
		sql = "sp_Notes_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(NoteName) & "', " & _
			  "'" & SQLEncode(NoteText) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		NoteID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		NotesErrorMessage = Server.URLEncode("Note '" & NoteName & "' created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&NotesErrorMessage=" & NotesErrorMessage
	ElseIf SubmitButton = "Save Note" Then
		If NoteText <> "" Then NoteText = FormatWebsite(NoteText)
		sql = "UPDATE Notes SET " & _
		      "NoteName = '" & SQLEncode(NoteName) & "', " & _
		      "NoteText = '" & SQLEncode(NoteText) & "' " & _
			  "WHERE NoteID = " & NoteID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		NotesErrorMessage = Server.URLEncode("Note updated.")
		Response.Redirect SCRIPT_NAME & "?NoteID=" & NoteID & "&Template=" & Template & "&NotesErrorMessage=" & NotesErrorMessage
	End If
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% End If %>

				

<%= formHidden("Template", Template) %>


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
