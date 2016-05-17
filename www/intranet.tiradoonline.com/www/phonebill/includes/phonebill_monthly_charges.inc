<fieldset>
	<legend>Monthly&nbsp;Charges</legend>

		<table cellpadding="3" align="right">
		<tr>
			<td class="frm_label">Monthly&nbsp;Charge:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MonthlyChargeName", "25", MonthlyChargeName, "PhoneBillElement", "Monthly Charge", "Monthly Charge") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Amount:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MonthlyChargeValue", "6", MonthlyChargeValue, "PhoneBillElement", "Monthly Charge Value", "Monthly Charge Value") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">&nbsp;</td>
			<td>
				<%= Submit_Button("SubmitButton", "Add Monthly Charge", "Button", "", "Add Monthly Charge") %>
			</td>
		</tr>
		</table>
<%
	sql = "sp_PhoneBillMonthlyCharges_get " & PhoneBillPhoneBillAccountID
	Set orsMonthlyCharges = oConn.Execute(sql)
	TotalMonthlyCharges = 0.00
	If NOT orsMonthlyCharges.EOF Then
%>
		<table cellpadding="3" width="100%" align="right">
<%		
		Do Until orsMonthlyCharges.EOF
			MonthlyChargeName = orsMonthlyCharges("MonthlyChargeName")
			MonthlyChargeValue = orsMonthlyCharges("MonthlyChargeValue")
			MonthlyChargeValue = FormatNumber(MonthlyChargeValue, 2)
			TotalMonthlyCharges = TotalMonthlyCharges + CDbl(MonthlyChargeValue)
%>
		<tr>
			<td class="frm_label" width="100%"><%= HTMLFormat(MonthlyChargeName) %>:</td>
			<td style="font-size:20; text-align:right;">
				<%= MonthlyChargeValue %>
			</td>
			<td>
				<%= EDIT_ICON %>
			</td>
			<td>
				<%= DELETE_ICON %>
			</td>
		</tr>
<%
			orsMonthlyCharges.MoveNext
		Loop
		orsMonthlyCharges.Close
%>
		<tr>
			<td colspan="4" class="PhoneBillElement frm_label">
				Monthly&nbsp;Charges:&nbsp;<%= FormatCurrency(TotalMonthlyCharges) %>
			</td>
</tr>
		</table>
<%	
	Else
%>
<div class="ErrorMessage">No Monthly Charges Found</div>
<% 
	End If 
	Set orsMonthlyCharges = Nothing
%>
</fieldset>
<style type="text/css">

	input[type=text] {
		text-align: right;
	}
</style>
