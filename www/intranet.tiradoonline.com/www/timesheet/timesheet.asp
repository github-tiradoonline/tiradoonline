<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "TimesheetTheme"
	PageThemeColor = TIMESHEET_THEME
	PageTitle = "Timesheet"
	HeaderTitle = "Timesheet"
	Response.Buffer = true
	
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	TimesheetID = Trim(Request("TimesheetID"))
	TimeSheetInvoiceNumber = Trim(Request("TimeSheetInvoiceNumber"))
	TimeSheetInvoiceDate = Trim(Request("TimeSheetInvoiceDate"))
	If TimeSheetInvoiceDate = "" Then TimeSheetInvoiceDate = Date
	TimesheetCompanyID = Trim(Request("TimesheetCompanyID"))
	TimesheetCompanyName = Trim(Request("TimesheetCompanyName"))
	TimesheetCompanyAddress1 = Trim(Request("TimesheetCompanyAddress1"))
	TimesheetCompanyAddress2 = Trim(Request("TimesheetCompanyAddress2"))
	TimesheetCompanyCity = Trim(Request("TimesheetCompanyCity"))
	TimesheetCompanyStateID = Trim(Request("TimesheetCompanyStateID"))
	If TimesheetCompanyStateID = "" Then TimesheetCompanyStateID = Application("StateID")
	TimesheetCompanyZipCode = Trim(Request("TimesheetCompanyZipCode"))
	TimesheetCompanyPhone = Trim(Request("TimesheetCompanyPhone"))
	TimesheetTypeID = Trim(Request("TimesheetTypeID"))
	TimesheetHourlyRate = Trim(Request("TimesheetHourlyRate"))
	TimesheetStartDate = Trim(Request("TimesheetStartDate"))
	If TimesheetStartDate = "" Then TimesheetStartDate = Date
	TimesheetEndDate = Trim(Request("TimesheetEndDate"))

	TimesheetBillable = Trim(Request("TimesheetBillable"))
	If TimesheetBillable = "" Then TimesheetBillable = "0"
	TimesheetDetailID = Trim(Request("TimesheetDetailID"))
	TimesheetDetailDate = Trim(Request("TimesheetDetailDate"))
	TimesheetHours = Trim(Request("TimesheetHours"))
	TimesheetDescription = Trim(Request("TimesheetDescription"))
	
	
	PaycheckID = Trim(Request("PaycheckID"))
	TimesheetCompanyID = Trim(Request("TimesheetCompanyID"))
	PaycheckDate = Trim(Request("PaycheckDate"))
	Gross = Trim(Request("Gross"))
	HourlyRate = Trim(Request("HourlyRate"))
	Federal = Trim(Request("Federal"))
	SocialSecurity = Trim(Request("SocialSecurity"))
	Medicare = Trim(Request("Medicare"))
	Withholding = Trim(Request("Withholding"))
	Disability = Trim(Request("Disability"))
	City = Trim(Request("City"))
	Notes = Trim(Request("Notes"))	
	
	'***************************************************'
	'******************* PAYCHECKS *********************'
	'***************************************************'
	If SubmitButton = "Create Paycheck" Then
		Set ors = Server.CreateObject("ADODB.Recordset")
		ors.Open "Paychecks", oConn, 1, 2, &H0002
		ors.AddNew
		ors("TimesheetCompanyID") = TimesheetCompanyID
		ors("PaymentDate") = PaycheckDate
		ors("HourlyRate") = HourlyRate
		ors("Gross") = Gross
		ors("Federal") = Federal
		ors("SocialSecurity") = SocialSecurity
		ors("Medicare") = Medicare
		ors("NY_Withholding") = Withholding
		ors("NY_Disability") = Disability
		ors("NY_City") = City
		ors("Notes") = Notes
		ors.Update
		PaycheckID = ors("PaycheckID")
		ors.Close
		Set ors = Nothing
		TimesheetErrorMessage = Server.URLEncode("Paycheck created.")
		RedirectString = SCRIPT_NAME & "?Template=paycheck&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Save Paycheck" Then
		sql = ""
		sql = sql & "UPDATE Paychecks SET "
		sql = sql & "PaymentDAte = '" & PaycheckDate & "', "
		sql = sql & "HourlyRate = " & HourlyRate & ", "
		sql = sql & "Gross = " & Gross & ", "
		sql = sql & "Federal = " & Federal & ", "
		sql = sql & "SocialSecurity = " & SocialSecurity & ", "
		sql = sql & "Medicare = " & Medicare & ", "
		sql = sql & "NY_Withholding = " & Withholding & ", "
		sql = sql & "NY_Disability = " & Disability & ", "
		sql = sql & "NY_City = " & City & ", "
		sql = sql & "Notes = '" & SQLEncode(Notes) & "' "
		sql = sql & "WHERE PaycheckID = " & PaycheckID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Company saved.")
		RedirectString = SCRIPT_NAME & "?Template=paycheck&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetErrorMessage=" & TimesheetErrorMessage & "&PaycheckID=" & PaycheckID
		Response.Redirect RedirectString




	'***************************************************'
	'******************* COMPANIES *********************'
	'***************************************************'
	ElseIf SubmitButton = "Create Company" Then
		'ssql = "INSERT INTO TimesheetCompany (UserID, TimesheetCompanyName, TimesheetCompanyAddress1, TimesheetCompanyAddress2, TimesheetCompanyCity, TimesheetCompanyStateID, TimesheetCompanyZipCode, TimesheetCompanyPhone) VALUES (" & _
		sql = "sp_TimesheetCompany_insert " & _
				Session("UserID") & ", " & _
				"'" & SQLEncode(TimesheetCompanyName) & "'," & _
				"'" & SQLEncode(TimesheetCompanyAddress1) & "'," & _
				"'" & SQLEncode(TimesheetCompanyAddress2) & "'," & _
				"'" & SQLEncode(TimesheetCompanyCity) & "'," & _
				"" & TimesheetCompanyStateID & "," & _
				"'" & SQLEncode(TimesheetCompanyZipCode) & "', " & _
				"'" & SQLEncode(TimesheetCompanyPhone) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		TimesheetCompanyID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		TimesheetErrorMessage = Server.URLEncode("Company '" & TimesheetCompanyName & "' created.")
		RedirectString = SCRIPT_NAME & "?Template=timesheet&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Save Company" Then
		sql = "UPDATE TimesheetCompany SET " & _
			  "TimesheetCompanyName = '" & SQLEncode(TimesheetCompanyName) & "', " & _
			  "TimesheetCompanyAddress1 = '" & SQLEncode(TimesheetCompanyAddress1) & "', " & _
			  "TimesheetCompanyAddress2 = '" & SQLEncode(TimesheetCompanyAddress2) & "', " & _
			  "TimesheetCompanyCity = '" & SQLEncode(TimesheetCompanyCity) & "', " & _
			  "TimesheetCompanyStateID = " & TimesheetCompanyStateID & ", " & _
			  "TimesheetCompanyZipcode = '" & SQLEncode(TimesheetCompanyZipCode) & "', " & _
			  "TimesheetCompanyPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(TimesheetCompanyPhone) & "') " & _
			  "WHERE TimesheetCompanyID = " & TimesheetCompanyID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Company&nbsp;saved.")
		RedirectString = SCRIPT_NAME & "?Template=" & Template & "&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Create Timesheet" Then
		sql = "sp_Timesheet_insert " & _
		TimesheetCompanyID & ", " & _
		TimesheetTypeID & ", " & _
		"'" & SQLEncode(TimeSheetInvoiceDate) & "', " & _
		"'" & SQLEncode(TimeSheetInvoiceNumber) & "', " & _
		TimesheetHourlyRate & ", " & _
		"'" & TimesheetStartDate & "', " & _
		"'" & TimesheetEndDate & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		TimeSheetID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		
		TimesheetErrorMessage = Server.URLEncode("Timesheet&nbsp;created.")
		RedirectString = SCRIPT_NAME & "?Template=timesheet_detail&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetID=" & TimesheetID
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Save Timesheet" Then
		sql = "UPDATE Timesheet SET " & _
			"TimesheetTypeID = " & TimesheetTypeID & ", " & _
			"TimesheetInvoiceDate = '" & SQLEncode(TimesheetInvoiceDate) & "', " & _ 
			"TimesheetInvoiceNumber = '" & SQLEncode(TimeSheetInvoiceNumber) & "', " & _ 
			"TimesheetHourlyRate = " & TimesheetHourlyRate & ", " & _
			"TimesheetStartDate = '" & SQLEncode(TimesheetStartDate) & "', " & _ 
			"TimesheetEndDate = '" & SQLEncode(TimesheetEndDate) & "' " & _ 
			"WHERE TimesheetID = " & TimesheetID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Timesheet&nbsp;saved.")
		RedirectString = SCRIPT_NAME & "?Template=" & Template & "&TimesheetID=" & TimesheetID & "&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Add Timesheet Entry" Then
		sql = "INSERT INTO TimesheetDetail " & _
			"(TimesheetID, TimesheetDetailDate, TimesheetHours, TimesheetDescription, TimesheetBillable) VALUES (" & _
			TimesheetID & ", " & _
			"'" & TimesheetDetailDate & "', " & _
			TimesheetHours & ", " & _
			"'" & SQLEncode(TimesheetDescription) & "', " & _
			TimesheetBillable & ")"
		'Response.Cookies("TimesheetDetailDate") = TimesheetDetailDate
		'Response.Cookies("TimesheetDetailDate").Expires = Date + 1
		WriteDebugger sql, Debugging, 0
		'Response.Write sql
		'Response.End
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Timesheet Entry added.")
		RedirectString = SCRIPT_NAME & "?Template=" & Template & "&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetID=" & TimesheetID & "&TimesheetDetailDate=" & Server.URLEncode(TimesheetDetailDate) & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "Save Timesheet Entry" Then
		sql = "UPDATE TimesheetDetail SET " & _
			"TimesheetDetailDate = '" & TimesheetDetailDate & "', " & _
			"TimesheetHours = " & TimesheetHours & ", " & _
			"TimesheetDescription = '" & SQLEncode(TimesheetDescription) & "', " & _
			"TimesheetBillable = " & TimesheetBillable & " " & _
			"WHERE TimesheetDetailID = " & TimesheetDetailID
		WriteDebugger sql, Debugging, 0
		'Response.Write sql
		'Response.End
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Timesheet Entry saved.")
		RedirectString = SCRIPT_NAME & "?Template=" & Template & "&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetID=" & TimesheetID & "&TimesheetDetailDate=" & Server.URLEncode(TimesheetDetailDate) & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	ElseIf SubmitButton = "DeleteTimesheetDetail" Then
		sql = "DELETE FROM TimesheetDetail WHERE TimesheetDetailID = " & TimesheetDetailID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		TimesheetErrorMessage = Server.URLEncode("Timesheet Entry deleted.")
		RedirectString = SCRIPT_NAME & "?Template=" & Template & "&TimesheetCompanyID=" & TimesheetCompanyID & "&TimesheetID=" & TimesheetID & "&TimesheetErrorMessage=" & TimesheetErrorMessage
		Response.Redirect RedirectString
	End If
%>


<!-- #include virtual="/includes/open_header.inc" -->


<% If Template = "" Then %>
<!-- #include file="templates/home.tem" -->
<% ElseIf Template = "company" Then %>
<!-- #include file="templates/company.tem" -->
<% ElseIf Template = "timesheet" Then %>
<!-- #include file="templates/timesheet.tem" -->
<% ElseIf Template = "timesheet_detail" Then %>
<!-- #include file="templates/timesheet_detail.tem" -->
<% ElseIf Template = "invoice" Then %>
<!-- #include file="templates/invoice.tem" -->
<% ElseIf Template = "paycheck" Then %>
<!-- #include file="templates/paycheck.tem" -->
<% ElseIf Template = "paycheck_balance" Then %>
<!-- #include file="templates/paycheck_balance.tem" -->
<% ElseIf Template = "reports" Then %>
<!-- #include file="templates/reports.tem" -->
<% End If %>



<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
