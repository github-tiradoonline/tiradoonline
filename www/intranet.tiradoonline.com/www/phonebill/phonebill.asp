<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "PhoneBillTheme"
	PageThemeColor = PHONEBILL_THEME
	PageTitle = "Phone Bills"
	HeaderTitle = "Phone Bills"
	Response.Buffer = true

	PhoneBillID = Trim(Request("PhoneBillID"))
	PhoneBillName = Trim(Request("PhoneBillName"))
	PhoneBillStartDate = Trim(Request("PhoneBillStartDate"))
	PhoneBillEndDate = Trim(Request("PhoneBillEndDate"))

	'Response.Write 	Template 
	'Response.Write 	SubmitButton
	
	'Response.End	


	PhoneBillPhoneBillAccountID = Trim(Request("PhoneBillPhoneBillAccountID"))

	'****************************************
	'PhoneBillSurchargesOtherFees	
	'****************************************
	AdministrativeFee = Trim(Request("AdministrativeFee"))
	If AdministrativeFee = "" Then AdministrativeFee = FormatNumber(0.00, 2)
	CountyGrossReceipts = Trim(Request("CountyGrossReceipts"))
	If CountyGrossReceipts = "" Then CountyGrossReceipts = FormatNumber(0.00, 2)
	FederalUniversalServiceCharge = Trim(Request("FederalUniversalServiceCharge"))
	If FederalUniversalServiceCharge = "" Then FederalUniversalServiceCharge = FormatNumber(0.00, 2)
	MTATelecom = Trim(Request("MTATelecom"))
	If MTATelecom = "" Then MTATelecom = FormatNumber(0.00, 2)
	RegulartoryCostRecoveryCharge = Trim(Request("RegulartoryCostRecoveryCharge"))
	If RegulartoryCostRecoveryCharge = "" Then RegulartoryCostRecoveryCharge = FormatNumber(0.00, 2)
	StateTelecommunicationsExcise = Trim(Request("StateTelecommunicationsExcise"))
	If StateTelecommunicationsExcise = "" Then StateTelecommunicationsExcise = FormatNumber(0.00, 2)

	'****************************************
	'PhoneBillGovernmentFeesTaxes	
	'****************************************
	ServiceFee911 = Trim(Request("ServiceFee911"))
	If ServiceFee911 = "" Then ServiceFee911 = FormatNumber(0.00, 2)
	CityDistrictSalesTax = Trim(Request("CityDistrictSalesTax"))
	If CityDistrictSalesTax = "" Then CityDistrictSalesTax = FormatNumber(0.00, 2)
	CitySalesTax = Trim(Request("CitySalesTax"))
	If CitySalesTax = "" Then CitySalesTax = FormatNumber(0.00, 2)
	LocalWireless911Surcharge = Trim(Request("LocalWireless911Surcharge"))
	If LocalWireless911Surcharge = "" Then LocalWireless911Surcharge = FormatNumber(0.00, 2)
	NYSalesTax = Trim(Request("NYSalesTax"))
	If NYSalesTax = "" Then NYSalesTax = FormatNumber(0.00, 2)

	'****************************************
	'PhoneBillMonthlyCharges	
	'****************************************
	PhoneBillMonthlyChargeID = Trim(Request("PhoneBillMonthlyChargeID"))
	MonthlyChargeName = Trim(Request("MonthlyChargeName"))
	MonthlyChargeValue = Trim(Request("MonthlyChargeValue"))
	If MonthlyChargeValue = "" Then MonthlyChargeValue = FormatNumber(0.00, 2)
	
	MonthlyDataChargeAmount = Trim(Request("MonthlyDataChargeAmount"))
	If MonthlyDataChargeAmount = "" Then MonthlyDataChargeAmount = 0
	MonthlyDataChargeMaxMB = Trim(Request("MonthlyDataChargeMaxMB"))
	If MonthlyDataChargeMaxMB = "" Then MonthlyDataChargeMaxMB = 0
	MonthlyDataChargeUsedMB = Trim(Request("MonthlyDataChargeUsedMB"))
	If MonthlyDataChargeUsedMB = "" Then MonthlyDataChargeUsedMB = 0
	
	PhoneBillAccountID = Trim(Request("PhoneBillAccountID"))
	PhoneBillAccountName = Trim(Request("PhoneBillAccountName"))
	PhoneBillAccountPhoneNumber = Trim(Request("PhoneBillAccountPhoneNumber"))
	
	PhoneDeviceID = Trim(Request("PhoneDeviceID"))
	PhoneDeviceName = Trim(Request("PhoneDeviceName"))
	
	PhoneBillErrorMessage = Trim(Request("PhoneBillErrorMessage"))
	
	If UCase(SubmitButton) = UCase("Create Phone Bill") Then
		sql = "sp_PhoneBill_insert " & _
			Session("UserID") & ", " & _
			"'" & SQLEncode(PhoneBillName) & "', " & _
			"'" & SQLEncode(PhoneBillStartDate) & "', " & _
			"'" & SQLEncode(PhoneBillEndDate) & "'"

		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillErrorMessage = Server.URLEncode("Phone Biil Created.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillErrorMessage=" & PhoneBillErrorMessage
		Response.Redirect RedirectURL
	ElseIf UCase(SubmitButton) = UCase("Save Phone Bill") Then
		sql = "sp_PhoneBill_update " & _
			PhoneBillID & ", " & _
			"'" & SQLEncode(PhoneBillName) & "', " & _
			"'" & SQLEncode(PhoneBillStartDate) & "', " & _
			"'" & SQLEncode(PhoneBillEndDate) & "'"

		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillErrorMessage = Server.URLEncode("Phone Biil Saved.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillErrorMessage=" & PhoneBillErrorMessage
		Response.Redirect RedirectURL
	ElseIf UCase(SubmitButton) = UCase("Create Phone Bill Account") Then
		sql = "sp_PhoneBillAccount_insert " & _
			Session("UserID") & ", " & _
			PhoneDeviceID & ", " & _
			"'" & SQLEncode(PhoneBillAccountName) & "', " & _
			"'" & SQLEncode(PhoneBillAccountPhoneNumber) & "'"
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillAccountErrorMessage = Server.URLEncode("Phone Biil Account Created.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillAccountErrorMessage=" & PhoneBillAccountErrorMessage
		Response.Redirect RedirectURL
	ElseIf UCase(SubmitButton) = UCase("Save Phone Bill Account") Then
		sql = "sp_PhoneBillAccount_update " & _
			PhoneBillAccountID & ", " & _
			PhoneDeviceID & ", " & _
			"'" & SQLEncode(PhoneBillAccountName) & "', " & _
			"'" & SQLEncode(PhoneBillAccountPhoneNumber) & "'"

		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillAccountErrorMessage = Server.URLEncode("Phone Biil Account Saved.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillAccountErrorMessage=" & PhoneBillAccountErrorMessage
		Response.Redirect RedirectURL
	ElseIf Template = "phonebill_monthlycharges" AND SubmitButton="Save" Then
		sql = "sp_PhoneBillMonthlyCharges_update " & _
			PhoneBillPhoneBillAccountID & ", " & _
				SQLEncode(AdministrativeFee) & ", " & _
				SQLEncode(CountyGrossReceipts) & ", " & _
				SQLEncode(FederalUniversalServiceCharge) & ", " & _
				SQLEncode(MTATelecom) & ", " & _
				SQLEncode(RegulartoryCostRecoveryCharge) & ", " & _
				SQLEncode(StateTelecommunicationsExcise) & ", " & _
				SQLEncode(ServiceFee911) & ", " & _
				SQLEncode(CityDistrictSalesTax) & ", " & _
				SQLEncode(CitySalesTax) & ", " & _
				SQLEncode(LocalWireless911Surcharge) & ", " & _
				SQLEncode(NYSalesTax) & ""
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillAccountErrorMessage = Server.URLEncode("Phone Biil Account Monthly Charges Saved.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillID=" & PhoneBillID & "&PhoneBillPhoneBillAccountID=" & PhoneBillPhoneBillAccountID & "&PhoneBillAccountErrorMessage=" & PhoneBillAccountErrorMessage
		Response.Redirect RedirectURL
	ElseIf Template = "phonebill_monthlycharges" AND SubmitButton="Add Monthly Charge" Then
		sql = "sp_PhoneBillMonthlyCharges_MonthlyCharge_insert " & _
			PhoneBillPhoneBillAccountID & ", " & _
				"'" & SQLEncode(MonthlyChargeName) & "', " & _
				SQLEncode(MonthlyChargeValue)

		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0			
		oConn.Execute sql
		PhoneBillAccountErrorMessage = Server.URLEncode("Phone Biil Account Monthly Charge Added.")
		RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&PhoneBillID=" & PhoneBillID & "&PhoneBillPhoneBillAccountID=" & PhoneBillPhoneBillAccountID & "&PhoneBillAccountErrorMessage=" & PhoneBillAccountErrorMessage
		Response.Redirect RedirectURL
	End If
%>

<!-- #include virtual="/includes/page_logs.inc" -->
<!-- #include virtual="/includes/functions.inc" -->

<!-- #include virtual="/includes/open_header.inc" -->

&nbsp;<br />
<% If Template = "" OR Template = "phonebill" Then %>
	<!-- #include file="templates/phonebill.tem" -->
<% ElseIf Template = "phonebill_account" Then %>
	<!-- #include file="templates/phonebill_account.tem" -->
<% ElseIf Template = "phonebill_monthlycharges" Then %>
	<!-- #include file="templates/phonebill_monthlycharges.tem" -->
<% End If %>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->

