<%
	If Request.Cookies("checkboxBanking") = "true" Then 
		BankingThemeColor = BANKING_THEME
	Else
		BankingThemeColor = "#fff"
	End If
	
	If Request.Cookies("checkboxCreditCards") = "true" Then 
		CreditCardsThemeColor = CREDITCARDS_THEME
	Else
		CreditCardsThemeColor = "#fff"
	End If
	
	If Request.Cookies("checkboxMonthlyExpenses") = "true" Then 
		MonthlyExpensesThemeColor = BANKING_MONTHLY_EXPENSES_THEME
	Else
		MonthlyExpensesThemeColor = "#fff"
	End If
	
	If Request.Cookies("checkboxReminders") = "true" Then 
		RemindersThemeColor = REMINDERS_THEME
	Else
		RemindersThemeColor = "#fff"
	End If

	If Session("Recovery") Then
		If Request.Cookies("checkboxRecovery") = "true" Then 
			RecoveryThemeColor = RECOVERY_THEME
		Else
			RecoveryThemeColor = "#fff"
		End If
	End If

	If Request.Cookies("checkboxInterviews") = "true" Then 
		JobsThemeColor = JOBS_THEME
	Else
		JobsThemeColor = "#fff"
	End If
		

	WidthPercent = "25%"
%>
<form action="<%= SCRIPT_NAME %>" id="frmCalendar" name="frmCalendar">
<table width="100%" cellpadding="5">
<tr>
	<td align="center" width="<%= WidthPercent %>" bgcolor="<%= BankingThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxBanking" name="checkboxBanking" value="1"<% If Request.Cookies("checkboxBanking") = "true" Then Response.Write " CHECKED" %> />
			Banking
	</td>
	<td align="center" width="<%= WidthPercent %>" bgcolor="<%= CreditCardsThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxCreditCards" name="checkboxCreditCards" value="1"<% If Request.Cookies("checkboxCreditCards") = "true" Then Response.Write " CHECKED" %> />
		Credit&nbsp;Cards
	</td>
	<td align="center" width="<%= WidthPercent %>" bgcolor="<%= MonthlyExpensesThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxMonthlyExpenses" name="checkboxMonthlyExpenses" value="1"<% If Request.Cookies("checkboxMonthlyExpenses") = "true" Then Response.Write " CHECKED" %> />
		Monthly&nbsp;Expenses
	</td>
	<td align="center" width="<%= WidthPercent %>" bgcolor="<%= RemindersThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxReminders" name="checkboxReminders" value="1"<% If Request.Cookies("checkboxReminders") = "true" Then Response.Write " CHECKED" %> />
		Reminders
	</td>
</tr>
<tr>
	<td colspan="2" align="center" width="<%= WidthPercent %>" bgcolor="<%= RecoveryThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxRecovery" name="checkboxRecovery" value="1"<% If Request.Cookies("checkboxRecovery") = "true" Then Response.Write " CHECKED" %> />
			Recovery
	</td>
	<td colspan="2" align="center" width="<%= WidthPercent %>" bgcolor="<%= JobsThemeColor %>" style="font-size:15px;border:1px solid #000;color:#fff;font-weight:bold;" class="TextShadow">
		<input type="checkbox" id="checkboxInterviews" name="checkboxInterviews" value="1"<% If Request.Cookies("checkboxInterviews") = "true" Then Response.Write " CHECKED" %> />
			Interviews
	</td>
</tr>
</table>


<%= formHidden("CurrentMonth", CurrentMonth) %>
<%= formHidden("CurrentYear", CurrentYear) %>

</form>

<script type="text/javascript">

	$("input:checkbox").click
	(
		function(evt)
		{
			if($(evt).is('checked'))
				$url = '<%= SCRIPT_NAME %>?CurrentMonth=<%= CurrentMonth %>&CurrentYear=<%= CurrentYear %>&SubmitButton=CHECKBOX&' + $(this).attr('id') + '=' + $(this).prop('checked');
			else
				$url = '<%= SCRIPT_NAME %>?CurrentMonth=<%= CurrentMonth %>&CurrentYear=<%= CurrentYear %>&SubmitButton=CHECKBOX&' + $(this).attr('id') + '=' + $(this).prop('checked');
				
			location.href = $url;
		}
	);
	

</script>
