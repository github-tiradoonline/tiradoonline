<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "RemindersTheme"
	PageThemeColor = REMINDERS_THEME
	PageTitle = "Reminders"
	HeaderTitle = "Reminders"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	Response.Buffer = true
	Session("Navigation") = "Reminders"
	Template = Trim(Request("Template"))

	ReminderID = Trim(Request("ReminderID")) 

	ReminderDate = Trim(Request("ReminderDate"))
	If ReminderDate = "" Then ReminderDate = Date

	ReminderTime = Trim(Request("ReminderTime"))
	If ReminderTime = "" Then ReminderTime = FormatDateTime(Now, 3)
	ReminderDateTime = ReminderDate & " " & ReminderTime

	ReminderName = Trim(Request("ReminderName"))
	ReminderDescription = Trim(Request("ReminderDescription"))
	
	If SubmitButton = "DeleteReminder" Then
		sql = "DELETE FROM Reminders WHERE ReminderID = " & ReminderID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ReminderErrorMessage = Server.URLEncode("Reminder deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&ReminderErrorMessage=" & ReminderErrorMessage
	ElseIf SubmitButton = "Create Reminder" Then
		sql = "INSERT INTO Reminders (UserID, ReminderDateTime, ReminderName, ReminderDescription) VALUES (" & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(ReminderDateTime) & "', " & _
			  "'" & SQLEncode(ReminderName) & "', " & _
			  "'" & SQLEncode(ReminderDescription) & "'" & _
			  ")"
		Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		ReminderErrorMessage = Server.URLEncode("Reminder '" & ReminderName & "' added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&ReminderErrorMessage=" & ReminderErrorMessage
	ElseIf SubmitButton = "Save Reminder" Then
		sql = "UPDATE Reminders SET " & _
			  "ReminderDateTime = '" & SQLEncode(ReminderDateTime) & "', " & _
			  "ReminderName = '" & SQLEncode(ReminderName) & "', " & _
			  "ReminderDescription = '" & SQLEncode(ReminderDescription) & "' " & _
			  "WHERE ReminderID = " & ReminderID
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		ReminderErrorMessage = Server.URLEncode("Reminder '" & ReminderName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&ReminderErrorMessage=" & ReminderErrorMessage
	End If	
%>


<!-- #include virtual="/includes/open_header.inc" -->

&nbsp;<br>
&nbsp;<br>

<form action="<%= SCRIPT_NAME %>" method="post">
<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
<tr>
	<td class="frm_label"><b>&nbsp;&nbsp;&nbsp;Reminder:</b></font>&nbsp;</td>
	<td>
		<%= formTextBox("Reminder_Name", "40", "", "RemindersElement", "Reminder", "Invalid Reminder") %>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff">
		<tr valign=top>
			<td>
				<%= Button("Button", "Create Reminder", "Button", "RemindersElement", "Create Monthly Expense", "formRemindersCreate()") %>
			</td>
			<td>
				<%= Button("Button", "View All Reminders", "Button", "RemindersElement", "View All Reminders", "location.href='" & SCRIPT_NAME & "?Template=Reminders'") %>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%= formHidden("Template", Template) %>
</form>
<hr width=100% size=2 noshade />
&nbsp;<br />

<!-- #include file="templates/reminders.tem" -->


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->	
