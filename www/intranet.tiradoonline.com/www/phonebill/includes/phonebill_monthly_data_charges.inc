<%
	sql = "sp_PhoneBillMonthlyDataCharges_get " & PhoneBillPhoneBillAccountID
	Set orsMonthlyDataCharges = oConn.Execute(sql)
	If NOT orsMonthlyDataCharges.EOF Then
		MonthlyDataChargeAmount = orsMonthlyDataCharges("MonthlyDataChargeAmount")
		MonthlyDataChargeMaxMB = orsMonthlyDataCharges("MonthlyDataChargeMaxMB")
		MonthlyDataChargeUsedMB = orsMonthlyDataCharges("MonthlyDataChargeUsedMB")
		orsMonthlyDataCharges.Close
	End If
	Set orsMonthlyDataCharges = Nothing
%>

<fieldset>
	<legend>Data&nbsp;Charges</legend>

		<table cellpadding="3" align="right">
		<tr>
			<td class="frm_label">Monthly&nbsp;Data&nbsp;Charge&nbsp;Amount:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MonthlyDataChargeAmount", "6", MonthlyDataChargeAmount, "PhoneBillElement", "Monthly Data Charge", "Monthly Data Charge") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Monthly&nbsp;Data&nbsp;Max&nbsp;(MB):</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MonthlyDataChargeMaxMB", "6", MonthlyDataChargeMaxMB, "PhoneBillElement", "Monthly Data Max (MB)", "Monthly Data Max (MB)") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Monthly&nbsp;Data&nbsp;Used&nbsp;(MB):</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MonthlyDataChargeUsedMB", "6", MonthlyDataChargeUsedMB, "PhoneBillElement", "Monthly Charge Value", "Monthly Charge Value") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
</fieldset>


