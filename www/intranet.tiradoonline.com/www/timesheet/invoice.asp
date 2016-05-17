<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->
<%
	Function ShowHour(h)

		If CDbl(h) = 1 Then
			ShowHour = "(" & h & " hour)"
		Else
			ShowHour = "(" & h & " hours)"
		End If
	End Function
	
	TemplateFile = Trim(Request("TemplateFile"))
	TimesheetID = Trim(Request("TimesheetID"))
	TemplateType = Trim(Request("TemplateType"))
	CC = Trim(Request("CC"))
	Invoice = FileRead(TemplateFile)
	
	If TemplateType = "Timesheet" Then 
		SignatureStart = Instr(Invoice, "<!-- SIGNATURE -->")
		SignatureEnd = Instr(Invoice, "<!-- SIGNATURE END -->")
		Footer = Mid(Invoice, SignatureStart, (SignatureEnd - SignatureStart))
		Invoice = Replace(Invoice, Footer, "")
	End If
	
	sql = "sp_Timesheet_Invoice_generate " & TimesheetID
	Set ors = oConn.Execute(sql)
	If NOT ors.EOF Then
		TimesheetType = ors("TimesheetType")
		FullName = ors("FullName")
		HomeAddress1 = ors("HomeAddress1")
		HomeAddress2 = ors("HomeAddress2")
		HomeCity = ors("HomeCity")
		HomeState = ors("HomeState")
		HomeZipCode = ors("HomeZipCode")
		HomePhone = ors("HomePhone")

		InvoiceDate = ors("InvoiceDate")
		InvoiceNumber = ors("InvoiceNumber")
		HourlyRate = ors("HourlyRate")
		CompanyName = ors("CompanyName")
		CompanyAddress1 = ors("CompanyAddress1")
		CompanyAddress2 = ors("CompanyAddress2")
		CompanyCity = ors("CompanyCity")
		CompanyState = ors("CompanyState")
		CompanyZipCode = ors("CompanyZipCode")
		CompanyPhone = ors("CompanyPhone")
		
		Invoice = Replace(Invoice, "###TEMPLATETYPE###", TemplateType)
		Invoice = Replace(Invoice, "###FULLNAME###", FullName)
		Invoice = Replace(Invoice, "###HOMEADDRESS1###", HomeAddress1)
		Invoice = Replace(Invoice, "###HOMEADDRESS2###", HomeAddress2 & "<br/>")
		Invoice = Replace(Invoice, "###HOMECITY###", HomeCity)
		Invoice = Replace(Invoice, "###HOMESTATE###", HomeState)
		Invoice = Replace(Invoice, "###HOMEZIPCODE###", HomeZipCode)
		Invoice = Replace(Invoice, "###HOMEPHONE###", HomePhone)

		Invoice = Replace(Invoice, "###INVOICENUMBER###", InvoiceNumber)
		Invoice = Replace(Invoice, "###INVOICEDATE###", InvoiceDate)
		Invoice = Replace(Invoice, "###COMPANYNAME###", CompanyName)
		Invoice = Replace(Invoice, "###COMPANYADDRESS1###", CompanyAddress1)
		Invoice = Replace(Invoice, "###COMPANYADDRESS2###", CompanyAddress2 & "<br/>")
		Invoice = Replace(Invoice, "###COMPANYCITY###", CompanyCity)
		Invoice = Replace(Invoice, "###COMPANYSTATE###", CompanyState)
		Invoice = Replace(Invoice, "###COMPANYZIPCODE###", CompanyZipCode)
		If NOT isNull(CompanyPhone) Then 
			Invoice = Replace(Invoice, "###COMPANYPHONE###", CompanyPhone)
		Else
			Invoice = Replace(Invoice, "###COMPANYPHONE###", "")
		End If
		
		InvoiceContents = ""

InvoiceContents = InvoiceContents & "<table width=""100%"" style=""background-color:#000000;"" cellspacing=""1"" cellpadding=""5"">"
InvoiceContents = InvoiceContents & "<tr style=""background-color:#dddddd;text-transform:uppercase;font-family:Tahoma;font-size:8pt;text-align:center;font-weight:bold;"">"
InvoiceContents = InvoiceContents & "	<td>Date</td>"
InvoiceContents = InvoiceContents & "	<td width=""100%"">Description</td>"
InvoiceContents = InvoiceContents & "	<td>Hours</td>"
If TimesheetType <> "Daily" AND  TimesheetType <> "Project" Then
	InvoiceContents = InvoiceContents & "	<td>Rate</td>"
End If 
InvoiceContents = InvoiceContents & "	<td>Amount</td>"
InvoiceContents = InvoiceContents & "</tr>"
GrandAmount = 0
GrandHours = 0
sql = "SELECT DISTINCT TimesheetDetailDate FROM TimesheetDetail WHERE TimesheetID = " & TimesheetID
Set ors2 = oConn.Execute(sql)
Counter = 0
If NOT ors2.EOF Then
	Do Until ors2.EOF
		If Counter Mod 2 = 0 Then
			bgcolor = "#ffffff"
		Else
			bgcolor = "#eeeeee"
		End If
		InvoiceContents = InvoiceContents & "<tr style=""background-color:" & bgcolor & ";font-family:'Courier New';font-size:10pt;"" valign=""middle"">"
		InvoiceContents = InvoiceContents & "	<td>"
		thisDate = ors2("TimesheetDetailDate")
		InvoiceContents =  InvoiceContents & "<b>" & WeekdayName(WeekDay(thisDate)) & "<br>" & thisDate & "</b></td><td><br />"
		sql = "SELECT TimesheetHours, TimesheetDescription, TimesheetBillable FROM TimesheetDetail WHERE TimesheetID = " & TimesheetID & " AND TimesheetDetailDate = '" & thisDate & "' ORDER BY create_dt DESC"
		Set ors3 = oConn.Execute(sql)
		TotalHours = 0
		InvoiceContents = InvoiceContents & "<ul>"
		Do Until ors3.EOF
			Hours = ors3("TimesheetHours")
			'If NOT TimesheetBillable Then 
				TotalHours = CDbl(TotalHours) + CDbl(Hours)
			'Else
				'TotalHours = 0.0
			'End If
			Details = ors3("TimesheetDescription")
			TimesheetBillable = ors3("TimesheetBillable")
			If NOT TimesheetBillable Then Details = Details & "<br /><b>(NOT BILLABLE)</b>"

			InvoiceContents = InvoiceContents & "<li>	" & Details & " " & ShowHour(Hours) & "<br />"
			ors3.MoveNext
		Loop
		InvoiceContents = InvoiceContents & "</ul>"
		InvoiceContents = InvoiceContents & "	</td>"
		InvoiceContents = InvoiceContents & "	<td align=""center"">"
		GrandHours = CDbl(GrandHours) + CDbl(TotalHours)
		InvoiceContents = InvoiceContents & "		<b>" & FormatNumber(TotalHours, 2) & "</b>"
		InvoiceContents = InvoiceContents & "	</td>"
		If TimesheetType <> "Daily" AND TimesheetType <> "Project" Then
			InvoiceContents = InvoiceContents & "	<td align=""center"">"
			InvoiceContents = InvoiceContents & "		<b>" & FormatNumber(HourlyRate, 2) & "</b>"
			InvoiceContents = InvoiceContents & "	</td>"
		End If 
		InvoiceContents = InvoiceContents & "	<td align=""right"">"
		If TimesheetBillable Then 
			TotalAmount = CDbl(TotalHours) * CDbl(HourlyRate)
		Else
			TotalAmount = 0.00
		End If
		GrandAmount = CDbl(GrandAmount) + CDbl(TotalAmount)
		If TimesheetType <> "Daily" AND TimesheetType <> "Project" Then
			InvoiceContents = InvoiceContents & "		<b>" & FormatNumber(TotalAmount, 2) & "</b>"
		End If 
		InvoiceContents = InvoiceContents & "	</td>"
		InvoiceContents = InvoiceContents & "</tr>"
		Counter = Counter + 1
		ors2.MoveNext
	Loop
End If
InvoiceContents = InvoiceContents & "<tr style=""background-color:#dddddd;text-transform:uppercase;font-family:'Courier New';font-size:10pt;text-align:center;font-weight:bold;"">"
InvoiceContents = InvoiceContents & "	<td colspan=""2"" align='right'>"
If TimesheetType = "Daily" OR TimesheetType = "Project" Then
	InvoiceContents = InvoiceContents & "	" & TimesheetType  & "&nbsp;Rate:&nbsp;&nbsp;" & FormatNumber(HourlyRate, 2)
End If 
InvoiceContents = InvoiceContents & "		&nbsp;"
InvoiceContents = InvoiceContents & "	</td>"
InvoiceContents = InvoiceContents & "	<td align=""center"">"
InvoiceContents = InvoiceContents & "		<b>" & FormatNumber(GrandHours, 2) & "</b>"
InvoiceContents = InvoiceContents & "	</td>"
If TimesheetType <> "Daily" AND TimesheetType <> "Project" Then
	InvoiceContents = InvoiceContents & "	<td align=""center"">"
	InvoiceContents = InvoiceContents & "		&nbsp;"
	InvoiceContents = InvoiceContents & "	</td>"
End If
		sql = "sp_Timehseet_TimesheetID_Total_get " & TimesheetID
		Set ors2 = oConn.Execute(sql)
		
		GrandAmount = 0.0
		If NOT ors2.EOF Then
			GrandAmount = ors2.Fields(0).Value
			ors2.Close
		End If
		Set ors2 = Nothing

InvoiceContents = InvoiceContents & "	<td align=""right"">"
InvoiceContents = InvoiceContents & "		<b>" & FormatNumber(GrandAmount, 2) & "</b>"
InvoiceContents = InvoiceContents & "	</td>"
InvoiceContents = InvoiceContents & "</tr>"
InvoiceContents = InvoiceContents & "</table>"

		Invoice = Replace(Invoice, "###INVOICEDETAILS###", InvoiceContents)
		ors.Close
		Response.Write Invoice

		sql = "sp_Timesheet_TimesheetID_TimesheetHTML_update " & _
			TimeSheetID & ", " & _
			"'" & SQLEncode(Invoice) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		
		
		'Response.Write "<br>SubmitButton:" & SubmitButton & "<br>"
		'Response.Write "Session(Email):" & Session("Email") & "<br>"
		If SubmitButton = "EmailInvoice" AND Session("Email") <> "" Then
			sql = "sp_Settings_get " & Session("DefaultUserID")
			WriteDebugger sql, Debugging, 0
			Set orsSettings = oConn.Execute(sql)
			If NOT orsSettings.EOF Then
				AdministratorEmail = orsSettings("AdministratorEmail")
				orsSettings.Close
			End If
			Set orsSettings = Nothing
			
			If TemplateType = "Invoice" Then
				Subject = FullName & " - " & CompanyName & " - " & "Invoice# " & InvoiceNumber & " ($" & FormatNumber(GrandAmount, 2) & ")"
			Else
				Subject = FullName & " - " & CompanyName & " - " & "Timesheet# " & InvoiceNumber
			End If

			SendEmail Session("Email"), AdministratorEmail, CC, Subject, Invoice, 1
			alertMessage = "Email sent to " & Session("Email")
			If CC <> "" Then alertMessage = alertMessage & " and " & CC
%>
<script type="text/javascript">
	
	alert('<%= alertMessage %>');
	redirectURL = "<%= "/timesheet/timesheet.asp?Template=timesheet_detail&TimesheetCompanyID=" & Trim(Request("TimesheetCompanyID")) & "&TimesheetID=" & Trim(Request("TimesheetID")) & "&TimesheetErrorMessage=" & Server.URLEncode("Email sent to " & Session("Email")) %>"
	location.href = redirectURL;
</script>
<%
		End If

directory = Server.MapPath("/timesheet/invoices")
FolderCreate directory

directory = Server.MapPath("/timesheet/invoices/" & Session("UserID"))
FolderCreate directory

InvoiceFile = Replace(CompanyName, " ", "_") & "_Invoice_" & InvoiceNumber & ".html"
FileName = directory & "\" & InvoiceFile
FileWrite FileName, Invoice
	End If
	Set ors = Nothing
%>

