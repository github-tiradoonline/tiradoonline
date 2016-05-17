<%
	sql = "sp_PhoneBillSurchargesOtherFees_get " & PhoneBillPhoneBillAccountID
	Set orsSurchargesOtherFees = oConn.Execute(sql)
	TotalSurchargesAndOtherFees = 0.00
	If NOT orsSurchargesOtherFees.EOF Then
		AdministrativeFee = orsSurchargesOtherFees("AdministrativeFee")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(AdministrativeFee)
		CountyGrossReceipts = orsSurchargesOtherFees("CountyGrossReceipts")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(CountyGrossReceipts)
		FederalUniversalServiceCharge = orsSurchargesOtherFees("FederalUniversalServiceCharge")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(FederalUniversalServiceCharge)
		MTATelecom = orsSurchargesOtherFees("MTATelecom")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(MTATelecom)
		RegulartoryCostRecoveryCharge = orsSurchargesOtherFees("RegulartoryCostRecoveryCharge")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(RegulartoryCostRecoveryCharge)
		StateTelecommunicationsExcise = orsSurchargesOtherFees("StateTelecommunicationsExcise")
		TotalSurchargesAndOtherFees = TotalSurchargesAndOtherFees + CDbl(StateTelecommunicationsExcise)
		orsSurchargesOtherFees.Close
	End If
	Set orsSurchargesOtherFees = Nothing
%>

<fieldset>
	<legend>Surcharges&nbsp;&amp;&nbsp;Other&nbsp;Fees</legend>

		<table cellpadding="3" align="right">
		<tr>
			<td class="frm_label">Administrative&nbsp;Fee:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("AdministrativeFee", "6", AdministrativeFee, "PhoneBillElement", "Administrative Fee", "Invalid Administrative Fee") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">County&nbsp;Gross&nbsp;Receipts:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("CountyGrossReceipts", "6", CountyGrossReceipts, "PhoneBillElement", "County Gross Receipts", "Invalid County Gross Receipts") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Federal&nbsp;Universal&nbsp;Service&nbsp;Charge:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("FederalUniversalServiceCharge", "6", FederalUniversalServiceCharge, "PhoneBillElement", "Federal Universal Service Charge", "Invalid Federal Universal Service Charge") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">MTA&nbsp;Telecom:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("MTATelecom", "6", MTATelecom, "PhoneBillElement", "MTA Telecom", "Invalid MTA Telecom") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Regulartory&nbsp;Cost&nbsp;Recovery&nbsp;Charge:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("RegulartoryCostRecoveryCharge", "6", RegulartoryCostRecoveryCharge, "PhoneBillElement", "Regulartory Cost Recovery Charge", "Invalid Regulartory Cost Recovery Charge") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">State&nbsp;Telecommunications&nbsp;Excise:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("StateTelecommunicationsExcise", "6", StateTelecommunicationsExcise, "PhoneBillElement", "State Telecommunications Excise", "Invalid State Telecommunications Excise") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="PhoneBillElement frm_label">
				Surcharges&nbsp;&amp;&nbsp;Other&nbsp;Fees: <%= FormatCurrency(TotalSurchargesAndOtherFees) %>
			</td>
		</tr>
		</table>

</fieldset>
