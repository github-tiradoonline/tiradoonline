<%
	sql = "sp_PhoneBillGovernmentFeesTaxes_get " & PhoneBillPhoneBillAccountID
	Set orsGovernmentFeesTaxes = oConn.Execute(sql)
	TotalGovernmentFeesTaxes = 0.00
	If NOT orsGovernmentFeesTaxes.EOF Then
		ServiceFee911 = orsGovernmentFeesTaxes("ServiceFee911")
		TotalGovernmentFeesTaxes = TotalGovernmentFeesTaxes + CDbl(ServiceFee911)
		CityDistrictSalesTax = orsGovernmentFeesTaxes("CityDistrictSalesTax")
		TotalGovernmentFeesTaxes = TotalGovernmentFeesTaxes + CDbl(CityDistrictSalesTax)
		CitySalesTax = orsGovernmentFeesTaxes("CitySalesTax")
		TotalGovernmentFeesTaxes = TotalGovernmentFeesTaxes + CDbl(CitySalesTax)
		LocalWireless911Surcharge = orsGovernmentFeesTaxes("LocalWireless911Surcharge")
		TotalGovernmentFeesTaxes = TotalGovernmentFeesTaxes + CDbl(LocalWireless911Surcharge)
		NYSalesTax = orsGovernmentFeesTaxes("NYSalesTax")
		TotalGovernmentFeesTaxes = TotalGovernmentFeesTaxes + CDbl(NYSalesTax)
		
		orsGovernmentFeesTaxes.Close
	End If
	Set orsGovernmentFeesTaxes = Nothing
%>

<fieldset>
	<legend>Government&nbsp;Fees&nbsp;&amp;&nbsp;Taxes</legend>

		<table cellpadding="3" align="right">
		<tr>
			<td class="frm_label">9-1-1&nbsp;Service&nbsp;Fee:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("ServiceFee911", "6", ServiceFee911, "PhoneBillElement", "9-1-1 Service Fee", "Invalid 9-1-1 Service Fee") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">County&nbsp;City&nbsp;District&nbsp;Sales&nbsp;Tax:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("CityDistrictSalesTax", "6", CityDistrictSalesTax, "PhoneBillElement", "City District Sales Tax", "Invalid City District Sales Tax") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">City&nbsp;Sales&nbsp;Tax:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("CitySalesTax", "6", CitySalesTax, "PhoneBillElement", "City Sales Tax", "Invalid City Sales Tax") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">Local&nbsp;Wireless&nbsp;911&nbsp;Surcharge:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("LocalWireless911Surcharge", "6", LocalWireless911Surcharge, "PhoneBillElement", "Local Wireless 911 Surcharge", "Invalid Local Wireless 911 Surcharge") %>
					</td>
					<td>
						<%= REQUIRED_ICON %>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="frm_label">NY&nbsp;Sales&nbsp;Tax:</td>
			<td>
				<table>
				<tr>
					<td>
						<%= formTextBox("NYSalesTax", "6", NYSalesTax, "PhoneBillElement", "NY Sales Tax", "NY Sales Tax") %>
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
				Government&nbsp;Fees&nbsp;&amp;&nbsp;Taxes: <%= FormatCurrency(TotalGovernmentFeesTaxes) %>
			</td>
		</tr>
		</table>

</fieldset>
