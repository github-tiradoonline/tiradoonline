<%
	sql = "sp_PhoneBillPhoneBillAccount_PhoneBillPhoneBillAccountID_SUM_get " & PhoneBillPhoneBillAccountID
	Response.Write sql
	'Response.End
	Set orsPhoneBillAccount = oConn.Execute(sql)
	If NOT orsPhoneBillAccount.EOF Then
		PhoneBillTotal = orsPhoneBillAccount("PhoneBillTotal")
		PhoneBillTotal = FormatCurrency(PhoneBillTotal)
		orsPhoneBillAccount.Close
	Else
		sql = "sp_PhoneBillMonthlyCharges_insert " & PhoneBillID
		oConn.Execute sql
		
		PhoneBillTotal = 0.00
	End If
	Set orsPhoneBillAccount = Nothing
%>

<table cellpadding="3" align="right">
<tr>
	<td class="frm_label">
		Surcharges&nbsp;&amp;Other&nbsp;Fees:
	</td>
	<td class="frm_label">
		<%= FormatCurrency(TotalSurchargesAndOtherFees) %>
	</td>
</tr>
<tr>
	<td class="frm_label">
		Government&nbsp;Fees&nbsp;Taxes:
	</td>
	<td class="frm_label">
		<%= FormatCurrency(TotalGovernmentFeesTaxes) %>
	</td>
</tr>
<tr>
	<td class="frm_label">
		Monthly&nbsp;Charges:
	</td>
	<td class="frm_label">
		<%= FormatCurrency(TotalMonthlyCharges) %>
	</td>
</tr>
<tr>
	<td colspan="2" class="frm_label">
		<div style="text-align:right; color:#ff0000; font-size:30px">
			<%= PhoneBillTotal %>
		</div>
	</td>
</tr>
</table>
