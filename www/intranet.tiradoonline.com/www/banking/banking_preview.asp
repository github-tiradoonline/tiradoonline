<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
		BankingFile = Trim(Request("BankingFile"))
		BankingFileName = Trim(Request("BankingFileName"))
		BankingID = Trim(Request("BankingID"))
		BankingAccountID = Trim(Request("BankingAccountID"))
		BankingDate = Trim(Request("BankingDate"))
		Comment = Trim(Request("Comment"))
		Payment = Trim(Request("Payment"))
		Preview = Trim(Request("Preview"))
		SubBankingAccountID = Trim(Request("SubBankingAccountID"))
		TransactionID = Trim(Request("TransactionID"))
		TransactionStatus = Trim(Request("TransactionStatus"))
		TransactionText = Trim(Request("TransactionText"))

	Active = Trim(Request("Active"))
	BodyText = Trim(Request("BodyText"))

	BankingAccountID = Trim(Request("BankingAccountID"))
	'***************** CREATE UPLOADS DIRECTORY ***************
	BankingUploadsDirectory = Server.MapPath("/banking/uploads/")
	FolderCreate BankingUploadsDirectory
	WriteDebugger BankingUploadsDirectory & " created.", Debugging, 0
	'*************************************************************

	'***************** CREATE UPLOADS DIRECTORY W/ BankingACCOUNTID ***************
	If BankingAccountID <> "" Then
		BankingUploadsDirectory = BankingUploadsDirectory & "\" & BankingAccountID
		FolderCreate BankingUploadsDirectory
		WriteDebugger BankingUploadsDirectory & " created.", Debugging, 0
	End If
	'*************************************************************


	'***************** CREATE UPLOADS DIRECTORY W/ BankingACCOUNTID W/ BankingID ***************
	If BankingID <> "" Then
		BankingUploadsDirectory = BankingUploadsDirectory & "\" & BankingID
		FolderCreate BankingUploadsDirectory
		WriteDebugger BankingUploadsDirectory & " created.", Debugging, 0
	End If
	'*************************************************************

	Session("BankingUploadsDirectory") = BankingUploadsDirectory
	
	EditBankingAccountName = Trim(Request("EditBankingAccountName"))
	BankingAccountName = Trim(Request("BankingAccountName"))
	EmailSent = Trim(Request("EmailSent"))
	MonthlyBankingErrorMessage = Trim(Request("MonthlyBankingErrorMessage"))
	TotalBanking = Trim(Request("TotalBanking"))
	MonthlyBillID = Trim(Request("MonthlyBillID"))
	MonthlyBillDate = Trim(Request("MonthlyBillDate"))
	MonthlyBillStartDate = Trim(Request("MonthlyBillStartDate"))
	MonthlyBillDesc = Trim(Request("MonthlyBillDesc"))
	MonthlyBillAmount = Trim(Request("MonthlyBillAmount"))
	CurrentDate = Trim(Request("CurrentDate"))
	If CurrentDate = "" Then CurrentDate = Date

	If SubmitButton = "GO" Then 
		CurrentMonth = Trim(Request("CurrentMonth"))
		CurrentYear = Trim(Request("CurrentYear"))
		CurrentDate = CurrentMonth & "/1/" & CurrentYear
	End If
	
	NextMonthDate = DateAdd("m", 1, CurrentDate)
	PreviousMonthDate = DateAdd("m", -1, CurrentDate)

	If SubmitButton = "Add New Transaction" Then
		sql = "sp_Transactions_insert null, " & Session("UserID") & ", '" & SQLEncode(TransactionText) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		TransactionID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		BankingErrorMessage = Server.URLEncode("Transaction '" & TransactionText & "' added.")
		redirectURL = SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&BankingID=" & BankingID & "&CurrentDate=" & Server.URLEncode(CurrentDate) & "&Template=" & Template & "&TransactionID=" & TransactionID & "&BankingErrorMessage=" & BankingErrorMessage
		Response.Redirect redirectURL
	ElseIf SubmitButton = "Save Daily Email Accounts" Then
		If Session("Administrator") = "1" Then
			sql = "UPDATE BankingAccount SET ReceiveEmails = 0"
		Else
			sql = "UPDATE BankingAccount SET ReceiveEmails = 0 WHERE UserID = " & Session("UserID")
		End If
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		
		For Each Item in Request.Form
			If InStr(Item, "BankingAccount_") > 0 Then
				BankingAccountID = Replace(Item, "BankingAccount_", "")
				ReceiveEmails = Request.Form(Item)
				If ReceiveEmails = "" Then ReceiveEmails = 0
				sql = "UPDATE BankingAccount SET ReceiveEmails = " & ReceiveEmails & " WHERE BankingAccountID = " & BankingAccountID
				WriteDebugger sql, Debugging, 0
				oConn.Execute sql
			End If 
		Next
		BankingErrorMessage = Server.URLEncode("Daily Email Accounts updated.")
		Response.Redirect SCRIPT_NAME & "?Template=daily_emails&BankingErrorMessage=" & BankingErrorMessage
	ElseIf SubmitButton = "ActivateAccount" Then
		sql = "UPDATE BankingAccount SET Active = " & Active & " WHERE BankingAccountID = " & BankingAccountID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		BankingErrorMessage = Server.URLEncode("Account updated.")
		Response.Redirect SCRIPT_NAME & "?Template=view_accounts&BankingErrorMessage=" & BankingErrorMessage
	ElseIf SubmitButton = "DeleteBankingAccount" Then
		sql = "UPDATE BankingAccount SET Active = 0 WHERE BankingAccountID = " & BankingAccountID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		BankingErrorMessage = Server.URLEncode("Account Deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=view_accounts&BankingErrorMessage=" & BankingErrorMessage
	ElseIf Action = "Edit" Then
		If SubmitButton = "Save" Then
			sql = "sp_BankingAccount_update " & BankingAccountID & ", '" & SQLEncode(EditBankingAccountName) & "'"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			BankingErrorMessage = Server.URLEncode("Account saved.")
			Response.Redirect SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Action=Edit&BankingErrorMessage=" & BankingErrorMessage
		ElseIf SubmitButton = "Delete" Then
			sql = "sp_BankingAccount_delete " & BankingAccountID
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			BankingAccountName = ors.Fields(0).Value
			ors.Close
			Set ors = Nothing
			BankingErrorMessage = Server.URLEncode("Account " & BankingAccountName & " deleted.")
			Response.Redirect SCRIPT_NAME & "?BankingErrorMessage=" & BankingErrorMessage
		ElseIf SubmitButton = "Add Bill" Then
			sql = "sp_MonthlyBills_insert " & BankingAccountID & ", '" & MonthlyBillStartDate & "', '" & MonthlyBillDate & "', '" & MonthlyBillDesc & "', " & MonthlyBillAmount
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			MonthlyBankingErrorMessage = Server.URLEncode("Monthly Bill Added.")
			Response.Redirect SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Action=" & Action & "&MonthlyBankingErrorMessage=" & MonthlyBankingErrorMessage
		ElseIf SubmitButton = "Update Bill" Then
			sql = "sp_MonthlyBills_update " & MonthlyBillID & ", '" & MonthlyBillStartDate & "', '" & MonthlyBillDate & "', '" & MonthlyBillDesc & "', " & MonthlyBillAmount
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			MonthlyBankingErrorMessage = Server.URLEncode("Monthly Bill Updated.")
			Response.Redirect SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Action=" & Action & "&MonthlyBankingErrorMessage=" & MonthlyBankingErrorMessage
		ElseIf SubmitButton = "DeleteBill" Then
			sql = "sp_MonthlyBills_delete " & MonthlyBillID
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			MonthlyBankingErrorMessage = Server.URLEncode("Monthly Bill deleted.")
			Response.Redirect SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Action=" & Action & "&MonthlyBankingErrorMessage=" & MonthlyBankingErrorMessage
		End If
	End If		
	If SubmitButton = "Create Account" Then
		BankingAccountExists = false
		sql = "SELECT BankingAccountID FROM BankingAccount WHERE UserID = " & Session("UserID") & " AND BankingAccountName = '" & BankingAccountName & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			BankingAccountExists = true
			ors.Close
		End If
		Set ors = Nothing
	
		If NOT BankingAccountExists Then
			sql = "sp_BankingAccount_insert " & Session("UserID") & ", '" & BankingAccountName & "'"
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			BankingAccountID = ors("BankingAccountID")
			ors.Close
			Set ors = Nothing
			BankingErrorMessage = Server.URLEncode(BankingAccountName & " account created.")
			Response.Redirect "/banking/banking.asp?BankingErrorMessage=" & BankingErrorMessage & "&BankingAccountID=" & BankingAccountID & "&Template=Add"
		Else
			BankingErrorMessage = "Account already exists"
			'DISPLAY ERROR MESSAGE
			
		End If
	ElseIf SubmitButton = "Email" Then

		'***** GET DATA FROM DATABASE *****
		sql = "SELECT * FROM BankingEmail WHERE UserID = " & Session("UserID")
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		ToEmail = ors("ToEmail")
		FromEmail = ors("FromEmail")
		Subject = ors("Subject")
		BodyText = ors("BodyText")
        CC = Trim(Request("CC"))
		If CC <> "" Then 
			Response.Cookies("BankingEmailCC") = CC
			Response.Cookies("BankingEmailCC").Expires = Date + 20
		End If
		ors.Close
		Set ors = Nothing
		'***** END GET DATA FROM DATABASE *****
		'Response.Write "CC:" & CC
		'***** vDebugging *****
		'Response.Write ToEmail & "<br />"
		'Response.Write FromEmail & "<br />"
		'Response.Write CC & "<br />"
		'Response.Write Subject & "<br />"
		'Response.Write BodyText
		'***** END OF vDebugging *****
		'Response.Write BodyText
		'***** SEND EMAIL *****
		sql = "sp_Settings_get " & Session("UserID")
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			AdministratorEmail = ors("AdministratorEmail")
			ors.Close
		End If
		Set ors = Nothing
		
		SendEmail ToEmail, AdministratorEmail, CC, Subject, BodyText, 1


		MailMessage = "Email sent to " & Session("Email")
		If CC <> "" Then MailMessage = MailMessage & " and " & CC
		
		RedirectString = Request.ServerVariables("SCRIPT_NAME") & "?Template=View&EmailSent=1&MailMessage=" & Server.URLEncode(MailMessage) & "&BankingAccountID=" & BankingAccountID & "&CurrentDate=" & CurrentDate
		
		Response.Redirect RedirectString
	End If

	PageTheme = "BankingTheme" 
	PageThemeColor = BANKING_THEME
	PageTitle = "Banking"
	HeaderTitle = "Banking"
	Response.Buffer = true
	ViewType = Trim(Request("ViewType"))
	If ViewType = "" Then
		sql = "sp_Banking_BankingAccountID_BankingDate_get " & Trim(Request("BankingAccountID")) & ", '" & CurrentDate & "'"
	ElseIf ViewType = "Transactions" Then
		sql = "sp_Banking_BankingAccountID_TransactionID_get " & Trim(Request("BankingAccountID")) & ", " & Trim(Request("TransactionID"))
	Else
		sql = "sp_Banking_BankingAccountID " & Trim(Request("BankingAccountID"))
	End If	
	
	WriteDebugger sql, Debugging, 0 & "<p>"
	Set ors = oConn.Execute(sql)

	'**********************
	'Get PreviousBanking
	'**********************
	If ViewType = "" Then
		sql = "sp_Banking_sum_UserID_BankingDate " & Trim(Request("BankingAccountID")) & ", '" & CurrentDate & "'"
		WriteDebugger sql, Debugging, 0 & "<p>"
		Set Sum_ors = oConn.Execute(sql)
		PreviousBanking = Sum_ors("PreviousBanking")
		TotalBanking = Sum_ors("TotalBanking")
		If IsNull(PreviousBanking) Then PreviousBanking = 0.0
		Sum_ors.Close
		Set Sum_ors = Nothing
	Else
		PreviousBanking = 0.0
	End If
	
	sql = "SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = " & Trim(Request("BankingAccountID"))
	WriteDebugger sql, Debugging, 0
	Set rs = oConn.Execute(sql)
	BankingAccountName = rs("BankingAccountName")
	rs.Close
	Set rs = Nothing

	If vDebugging Then Response.Write "Previous&nbsp;Banking:&nbsp;" & PreviousBanking & "<p>"
%>
		<% If Preview = "" Then %>
		<%
			BankingText = "<table cellspacing=1 cellpadding=3 width=""700"" bgcolor=""#c6ba9c"" border=0>" & vbCRLF


			BankingText = BankingText & "<tr bgcolor=""#639a63"">" & vbCRLF
			BankingText = BankingText & "<td colspan=""5"" align=""center"">" & vbCRLF
			BankingText = BankingText & "<table cellspacing=0 cellpadding=0 border=0 width=""100%"">" & vbCRLF
			BankingText = BankingText & "<tr class=""BankingSubElement"">" & vbCRLF
			BankingText = BankingText & "<td align=""center""><font face=""Arial"" size=2 color=""#ffffff""><b>Account#&nbsp;" & Trim(Request("BankingAccountID")) & "&nbsp;-&nbsp;" & BankingAccountName & "&nbsp;(&nbsp;$" & FormatNumber(TotalBanking, 2) & "&nbsp;)</td>" & vbCRLF
			BankingText = BankingText & "</tr>" & vbCRLF
			BankingText = BankingText & "</table>" & vbCRLF
			BankingText = BankingText & "</td>" & vbCRLF
			BankingText = BankingText & "</tr>" & vbCRLF


			If NOT ors.EOF Then
				BankingText = BankingText  & "<tr bgcolor=""#ded7b5"">" & vbCRLF
				BankingText = BankingText  & "<td align=""right""><font face=""Arial"" size=2><b>Date</b>&nbsp;</td>" & vbCRLF
				BankingText = BankingText  & "<td><font face=""Arial"" size=2><b>Linked&nbsp;Account</b>&nbsp;</td>" & vbCRLF
				BankingText = BankingText  & "<td width=""100%""><font face=""Arial"" size=2><b>Transaction</b></td>" & vbCRLF
				BankingText = BankingText  & "<td align=""right""><font face=""Arial"" size=2><b>&nbsp;Amount</b>&nbsp;</td>" & vbCRLF
				BankingText = BankingText  & "<td align=""right""><font face=""Arial"" size=2><b>&nbsp;Banking</b>&nbsp;</td>" & vbCRLF
				BankingText = BankingText  & "</tr>" & vbCRLF
			End If 

			FONT_PAYMENT = "GREEN"
			If CDbl(PreviousBanking) <= 0 Then FONT_PAYMENT = "#ff0000"
			BankingText = BankingText & "<tr bgcolor=""#c6ba9c"">" & vbCrLF
			BankingText = BankingText & "	<td align=right colspan=4><font face=""Arial"" size=2 color=""#000000""><b>Previous Banking</b>&nbsp;&nbsp;</td>" & vbCrLF
			BankingText = BankingText & "	<td align=right><font face=""Arial"" size=2 color=""" & FONT_PAYMENT & """>&nbsp;<b>" & "$" & FormatNumber(PreviousBanking, 2) & "</b>&nbsp;&nbsp;</td>" & vbCrLF
			BankingText = BankingText & "</tr>" & vbCrLF

			Banking = PreviousBanking
			'BankingText = ""
			Redim BankingArray(1)
			x = 0
			If NOT ors.EOF Then
				Do Until ors.EOF
					Redim PRESERVE BankingArray(x)
					BankingID = ors("BankingID")
					BankingFile = ors("BankingFile")
					BankingFileName = ors("BankingFileName")
					SubBankingAccountID = ors("SubBankingAccountID")
					SubAccountName = ors("SubAccountName")
					BankingAccountID = ors("BankingAccountID")					 
					BankingDate = FormatDateTime(ors("BankingDate"), 2)
					Transaction = ors("Description")
					Comment = Trim(ors("Comment"))
					Payment = ors("Payment")
					Banking = CDbl(Banking) + CDbl(Payment)
					FONT_PAYMENT = "GREEN"
					If CDbl(Payment) <= 0 Then FONT_PAYMENT = "#ff0000"
					'If (isNull(SubBankingAccountID) OR Trim(SubBankingAccountID) = "") OR (BankingAccountID = SubBankingAccountID) Then 
					'	SubAccountName = ""
					'	If BankingAccountID = SubBankingAccountID Then 
					'		Banking = CDbl(Banking) - CDbl(Payment)
					'	Else
					'		Banking = CDbl(Banking) + CDbl(Payment)
					' 	End If
					'Else
					'		FONT_PAYMENT = "GREEN"
					'		'If BankingAccountName = SubAccountName Then 
					'		'	Banking = CDbl(Banking) + (CDbl(Payment))
					'		'Else
					'		'	Banking = CDbl(Banking) - (CDbl(Payment))
					'		'	'Payment = ABS(CDbl(Payment))
					'		'End If
					'		'Payment = CDbl(Payment) - (CDbl(Payment))
					'End If
					FONT_Banking = "GREEN"
					If CDbl(Banking) <= 0 Then FONT_Banking = "#ff0000"
					If Len(CStr(BankingDate)) > 7 Then
						DateTab = vbTab
					Else
						DateTab = vbTab & vbTab
					End If
					If Len(Transaction) <= 7 Then
						TabToUse = vbTab & vbTab & vbTab & vbTab
					ElseIf Len(Transaction) <= 15 Then
						TabToUse = vbTab & vbTab & vbTab 
					Else
						TabToUse = vbTab & vbTab
					End If
					If Len(CStr(FormatNumber(Payment,2))) > 7 Then
						PaymentTab = vbTab
					Else
						PaymentTab = vbTab & vbTab
					End If
					'BankingText = ""
					BankingText = BankingText & "<tr bgcolor=""#c6ba9c"" valign=top>" & vbCrLF
					If Comment <> "" Then
						BankingText = BankingText & "	<td rowspan=2 bgcolor=""#ffffff"" align=""right"">&nbsp;<a href=""" & Request.ServerVariables("SCRIPT_NAME") & "?Template=Edit&BankingID=" & BankingID & """><font face=""Arial"" size=2 color=""#000000"">" & BankingDate & "</a>&nbsp;&nbsp;</td>" & vbCrLF
						BankingText = BankingText & "	<td rowspan=2 bgcolor=""#ffffff"" align=""right"">&nbsp;<a href=""" & Request.ServerVariables("SCRIPT_NAME") & "?Template=Edit&BankingID=" & BankingID & """><font face=""Arial"" size=2 color=""#000000"">" & SubAccountName & "</a>&nbsp;&nbsp;</td>" & vbCrLF
					Else
						BankingText = BankingText & "	<td bgcolor=""#ffffff"" align=""right"">&nbsp;<a href=""" & Request.ServerVariables("SCRIPT_NAME") & "?Template=Edit&BankingID=" & BankingID & """><font face=""Arial"" size=2 color=""#000000"">" & BankingDate & "</a>&nbsp;&nbsp;</td>" & vbCrLF
						BankingText = BankingText & "	<td bgcolor=""#ffffff"" align=""right"">&nbsp;<a href=""" & Request.ServerVariables("SCRIPT_NAME") & "?Template=Edit&BankingID=" & BankingID & """><font face=""Arial"" size=2 color=""#000000"">" & SubAccountName & "</a>&nbsp;&nbsp;</td>" & vbCrLF
					End If
					
					BankingImage = ""
					BankingText = BankingText & "	<td bgcolor=""#ffffff""><a href=""" & Request.ServerVariables("SCRIPT_NAME") & "?Template=Edit&BankingAccountID=" & BankingAccountID & "&BankingID=" & BankingID & """><font face=""Arial"" size=2 color=""green"">" & Transaction & "</a>&nbsp;" & BankingImage & "</td>" & vbCrLF
					If Comment <> "" Then
						BankingText = BankingText & "	<td rowspan=2 align=right valign=""top"" bgcolor=""#ffffff""><font face=""Arial"" size=2 color=""" & FONT_PAYMENT & """><nobr>$" & FormatNumber(Payment, 2) & "</nobr></td>" & vbCrLF
					Else
						BankingText = BankingText & "	<td align=right valign=""top"" bgcolor=""#ffffff""><font face=""Arial"" size=2 color=""" & FONT_PAYMENT & """><nobr>" & "$" & FormatNumber(Payment, 2) & "</td>" & vbCrLF
					End If
					If Comment <> "" Then
						'TotalBanking = "$" & Replace(FormatNumber(Banking, 2), "-", "")
						TotalBanking = FormatNumber(Banking, 2)
						'BankingText = BankingText & "	<td rowspan=2 align=right bgcolor=""#ffffff"" align=""right""><font face=""Arial"" size=2 color=""" & FONT_Banking & """><nobr>" & "$" & Replace(FormatNumber(Banking, 2), "-", "") & "</nobr></td>" & vbCrLF
						BankingText = BankingText & "	<td rowspan=2 align=right bgcolor=""#ffffff"" align=""right""><font face=""Arial"" size=2 color=""" & FONT_Banking & """><nobr>" & "$" & FormatNumber(Banking, 2) & "</nobr></td>" & vbCrLF
					Else
						'TotalBanking = "$" & Replace(FormatNumber(Banking, 2), "-", "")
						TotalBanking = FormatNumber(Banking, 2)
						'BankingText = BankingText & "	<td align=right bgcolor=""#ffffff"" align=""right""><font face=""Arial"" size=2 color=""" & FONT_Banking & """><nobr>" & "$" & Replace(FormatNumber(Banking, 2), "-", "") & "</nobr></td>" & vbCrLF
						BankingText = BankingText & "	<td align=right bgcolor=""#ffffff"" align=""right""><font face=""Arial"" size=2 color=""" & FONT_Banking & """><nobr>" & "$" & FormatNumber(Banking, 2) & "</nobr></td>" & vbCrLF
					End If
					BankingText = BankingText & "</tr>" & vbCrLF
					If Comment <> "" Then
						BankingText = BankingText & "<tr>" & vbCrLF
						BankingText = BankingText & "	<td bgcolor=""#d6e3ce""><font face=""Arial"" size=1 color=""#000000"">" & Comment & "&nbsp;</td>" & vbCrLF
						BankingText = BankingText & "</tr>" & vbCrLF
					End If
					BankingArray(x) = BankingText
					x = x + 1
					ors.MoveNext
				Loop

				ors.Close
				Set ors = Nothing
			Else
				TotalBanking = Banking
				BankingText = BankingText & "<tr>" & vbCrLF
				BankingText = BankingText & "	<td bgcolor=""#ffffff"" align=center colspan=5><font face=""Arial"" size=2 color=""green""><b>No Transactions found.</b></td>" & vbCrLF
				BankingText = BankingText & "</tr>" & vbCrLF
				'BankingArray(0) = BankingText
			End If
			FONT_PAYMENT = "GREEN"
			If CDbl(TotalBanking)  <= 0 Then 
				FONT_PAYMENT = "#ff0000"
				TotalBanking = "$" & FormatNumber(TotalBanking, 2)
			End If
			BankingText = BankingText & "<tr bgcolor=""#c6ba9c"">" & vbCrLF
			BankingText = BankingText & "	<td align=right colspan=4 width=""100%""><font face=""Arial"" size=2 color=""#000000""><b>Final&nbsp;Banking</b>&nbsp;&nbsp;</td>" & vbCrLF
			BankingText = BankingText & "	<td align=right><font face=""Arial"" size=2 color=""" & FONT_PAYMENT & """>&nbsp;<b>" & TotalBanking & "</b>&nbsp;&nbsp;</td>" & vbCrLF
			BankingText = BankingText & "</tr>" & vbCrLF
%>
		<% End If %>
<%
			
			BankingText = BankingText & "</table></td></tr></table>"
%>

<%= BankingText %>
<!-- #include virtual="/includes/close_connection.inc" -->	
</body>
</html>
