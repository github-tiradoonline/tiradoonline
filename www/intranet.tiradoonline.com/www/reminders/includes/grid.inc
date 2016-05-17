<table bgcolor="#000000" cellpadding="10" id="GridView" name="GridView" class="shadow">
<tr bgcolor="<%= REMINDERS_THEME %>" style="color:#fff" valign="top">
	<td align="right" style="font-size:15px">
		<b>Date/Time</b>
	</td>
	<td style="font-size:15px">
		<b>Reminder</b>
	</td>
	<td>
		&nbsp;
	</td>
</tr>

<%
		Do Until ors.EOF
			ReminderID = ors("ReminderID")
			ReminderDateTime = ors("ReminderDateTime")
			ReminderDate = FormatDateTime(ReminderDateTime, 2)
			ReminderWeekday = WeekDayName(WeekDay(ReminderDate))
			ReminderTime = FormatDateTime(ReminderDateTime, 3)
			ReminderName = ors("ReminderName")
			ReminderDescription = ors("ReminderDescription")
%>
<tr class="GridViewRow" valign="top">
	<td style="font-size:15px" align="right"><b><%= ReminderWeekday %><br /><%= HTMLFormat(ReminderDate) %><br /><%= HTMLFormat(ReminderTime) %></b></td>
	<td style="font-size:15px">
		<a href="<%= SCRIPT_NAME %>?ReminderID=<%= ReminderID %>&Template=<%= Template %>&Action=Edit"><b><%= HTMLFormat(ReminderName) %></b></a>
		<br /><%= HTMLFormat2(ReminderDescription) %>
	</td>
	<td>
		<!-- <%= Button("Button", "Delete", "DeleteButton", "", "Delete", "DeleteItem('Are you sure you want to delete this Reminder?', '" & SCRIPT_NAME & "?Template=" & Template & "&SubmitButton=DeleteReminder&ReminderID=" & ReminderID & "')") %> -->
		<a onclick="DeleteItem('Are you sure you want to delete this reminder?', '<%= SCRIPT_NAME %>?SubmitButton=DeleteReminder&Template=<%= Template %>&ReminderID=<%= ReminderID %>')"><%= DELETE_ICON %></a>
	</td>
</tr>

<%
			ors.MoveNext
		Loop
		ors.Close
%>
</table>
