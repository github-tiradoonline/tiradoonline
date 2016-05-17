<% If TimesheetCompanyID <> "" Then %>

<table width="100%">
<tr>
	<td>
		<%= Button("Button", "Paychecks", "Button", "", "Paychecks", "location.href='" & SCRIPT_NAME & "?Template=paycheck&TimesheetCompanyID=" & TimesheetCompanyID & "'") %>
	</td>
	<td align="center">
		<%= Button("Button", "Paycheck Balance", "Button", "", "Paycheck Balance", "location.href='" & SCRIPT_NAME & "?Template=paycheck_balance&TimesheetCompanyID=" & TimesheetCompanyID & "'") %>
	</td>
	<td align="right">
		<%= Button("Button", "Timesheets", "Button", "", "Timesheets", "location.href='" & SCRIPT_NAME & "?Template=timesheet&TimesheetCompanyID=" & TimesheetCompanyID & "'") %>
	</td>
</tr>
</table>

<% End If %>