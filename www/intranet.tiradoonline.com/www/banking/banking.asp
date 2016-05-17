<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<!-- #include virtual = "/includes/upload.inc" -->
<%
	If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
		ks = Upload.UploadedFiles.keys
    	if (UBound(ks) <> -1) then
        	for each fileKey in Upload.UploadedFiles.keys
            	BankingFileName = Upload.UploadedFiles(fileKey).FileName
	        next
    	end if
		
		If BankingFileName <> "" Then 		
			BankingFile = "1"
		Else
			BankingFile = "0"
		End If

		
		BankingAccountID = Upload.Form("BankingAccountID")
		BankingDate = Upload.Form("BankingDate")
		Comment = Upload.Form("Comment")
		Payment = Upload.Form("Payment")
		Preview = Upload.Form("Preview")
		SubBankingAccountID = Upload.Form("SubBankingAccountID")
		TransactionID = Upload.Form("TransactionID")
		TransactionStatus = Upload.Form("TransactionStatus")
		TransactionText = Upload.Form("TransactionText")
		
		If SubmitButton = "Add" Then
			If TransactionStatus = "TEXT" Then TransactionID = "null"
			If SubBankingAccountID = "" Then SubBankingAccountID = "null"
							
			sql = "sp_Banking_insert " & _
				Session("UserID") & ", " & _
				BankingAccountID & ", " & _
				SubBankingAccountID & ", " & _
				"'" & BankingDate & "', " & _
				TransactionID & ", " & _
				"'" & SQLEncode(TransactionText) & "', " & _
				"'" & SQLEncode(Comment) & "', " & _
				Payment & ", " & _
				BankingFile & ", " & _
				"'" & SQLEncode(FormatFileName(BankingFileName)) & "'"
			
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)

			If NOT ors.EOF Then
				BankingID = ors.Fields(0).Value
				If BankingFile = "1" Then
					Set fso = CreateObject("Scripting.FileSystemObject")
					OriginalFileName = BankingUploadsDirectory & "\" & BankingFileName
					BankingUploadsDirectory = BankingUploadsDirectory & "\" & BankingID
					FolderCreate BankingUploadsDirectory
					WriteDebugger BankingUploadsDirectory & " created.", Debugging, 0
					NewFileName = BankingUploadsDirectory & "\" & FormatFileName(BankingFileName)
   					fso.MoveFile OriginalFileName, NewFileName
					Set fso = Nothing
				End If
				ors.Close
			End If
			Set ors = Nothing
			BankingErrorMessage = Server.URLEncode("Transaction Added.")
			RedirectURL = SCRIPT_NAME & "?BankingErrorMessage=" & BankingErrorMessage & "&BankingAccountID=" & BankingAccountID & "&CurrentDate=" & BankingDate & "&Template=View"
			Response.Redirect RedirectURL
		ElseIf SubmitButton = "Save" Then
			BankingID = Upload.Form("BankingID")
			If TransactionStatus = "TEXT" Then TransactionID = "null"
			If SubBankingAccountID = "" Then SubBankingAccountID = "null"
				
			If BankingFile = "0" Then 
				BankingFile = Upload.Form("BankingOldFile")
				BankingFileName = Upload.Form("BankingOldFileName")
				BankingFileName = FormatFileName(BankingFileName)
			Else
				Set fso = CreateObject("Scripting.FileSystemObject")
				OriginalFileName = BankingUploadsDirectory & "\" & BankingFileName
				NewFileName = BankingUploadsDirectory & "\" & FormatFileName(BankingFileName)
				If NOT fso.FileExists(NewFileName) Then
					fso.MoveFile OriginalFileName, NewFileName
				End If
				Set fso = Nothing
			End If
			

			sql = "sp_Banking_update " & _
				Session("UserID") & ", " & _
				BankingID & ", " & _
				"'" & BankingDate & "', " & _
				TransactionID & ", " & _
				"'" & SQLEncode(TransactionText) & "', " & _
				"'" & SQLEncode(Comment) & "', " & _
				Payment & ", " & _
				BankingFile & ", " & _
				"'" & SQLEncode(FormatFileName(BankingFileName)) & "'"

			WriteDebugger sql, Debugging, 0			
			oConn.Execute sql

			BankingErrorMessage = Server.URLEncode("Transaction Saved.")
			RedirectURL = SCRIPT_NAME & "?BankingErrorMessage=" & BankingErrorMessage & "&BankingAccountID=" & BankingAccountID & "&CurrentDate=" & BankingDate & "&Template=View"
			Response.Redirect RedirectURL
		End If
		Set Upload = Nothing
	Else
		BankingFile = Trim(Request("BankingFile"))
		If BankingFile = "" Then BankingFile = "0"
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
	End If
%>
<%
	PageTheme = "BankingTheme" 
	PageThemeColor = BANKING_THEME
	PageTitle = "Banking"
	HeaderTitle = "Banking"
	Response.Buffer = true
	
	'Response.Write "BankingFile:&nbsp;" & BankingFile
%>
<%

	If Preview = "" Then
%>
<!-- #include virtual="/includes/login.inc" -->


<% End If %>



<%
	checkboxBanking = Trim(Request("checkboxBanking"))
	If SubmitButton = "EmptyTrash" Then
		sql = "DELETE FROM Banking WHERE BankingID IN (" & checkboxBanking & ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		BankingErrorMessage = Server.URLEncode("Banking Transactions Deleted")
		redirectURL = SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Template=" & Template & "&BankingErrorMessage=" & BankingErrorMessage
	End If
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
	LinkedUserID = Trim(Request("LinkedUserID"))
	BankingAccountLinkedID = Trim(Request("BankingAccountLinkedID"))
	
	If SubmitButton = "GO" Then 
		CurrentMonth = Trim(Request("CurrentMonth"))
		CurrentYear = Trim(Request("CurrentYear"))
		CurrentDate = CurrentMonth & "/1/" & CurrentYear
	End If
	
	NextMonthDate = DateAdd("m", 1, CurrentDate)
	PreviousMonthDate = DateAdd("m", -1, CurrentDate)

	If SubmitButton = "DeleteBalanceAccountLinked" Then
		sql = "sp_BankingAccountLinked_delete " & _
			BankingAccountLinkedID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		BankingErrorMessage = Server.URLEncode("User removed from Linked Account")
		redirectURL = SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Template=" & Template & "&BankingErrorMessage=" & BankingErrorMessage
		Response.Redirect redirectURL
	ElseIf SubmitButton = "Add User to Account" Then
		sql = "sp_BankingAccountLinked_insert " & _
			BankingAccountID & ", " & _
			LinkedUserID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		BankingErrorMessage = Server.URLEncode("User Linked to Account")
		redirectURL = SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&Template=" & Template & "&BankingErrorMessage=" & BankingErrorMessage
		Response.Redirect redirectURL
	ElseIf SubmitButton = "Add New Transaction" Then
		sql = "sp_Transactions_insert null, " & Session("UserID") & ", '" & SQLEncode(TransactionText) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		TransactionID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		BankingErrorMessage = Server.URLEncode("Transaction '" & TransactionText & "' added.")
		redirectURL = SCRIPT_NAME & "?BankingAccountID=" & BankingAccountID & "&BankingID=" & BankingID & "&CurrentDate=" & Server.URLEncode(CurrentDate) & "&Template=" & Template & "&TransactionID=" & TransactionID & "&BankingErrorMessage=" & BankingErrorMessage & "&BankingDate=" & Server.URLEncode(BankingDate) & "&Payment=" & Server.URLEncode(Payment) & "&Comment=" & Server.URLEncode(Comment)
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
		If SubmitButton = "Search" Then 
			Subject = "intranet.tiradoonline.com -- Search Results"
		End If
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
		
		
		'Response.Write BodyText
		'Response.End
		SendEmail ToEmail, AdministratorEmail, CC, Subject, BodyText, 1


		MailMessage = "Email sent to " & Session("Email")
		If CC <> "" Then MailMessage = MailMessage & " and " & CC
		
		'If InStr(UCase(SCRIPT_NAME), 
		
		RedirectString = Request.ServerVariables("SCRIPT_NAME") & "?Template=View&EmailSent=1&MailMessage=" & Server.URLEncode(MailMessage) & "&BankingAccountID=" & BankingAccountID & "&CurrentDate=" & CurrentDate
		If SubmitButton = "Search" Then 
			RedirectString = Request.ServerVariables("SCRIPT_NAME") & "?Template=Search&EmailSent=1&MailMessage=" & Server.URLEncode(MailMessage)
		End If
		
		Response.Redirect RedirectString
	End If
	
%>

<% If Template <> "banking_email" Then %>
<!-- #include virtual="/includes/open_header.inc" -->

<form action="<%= SCRIPT_NAME %>" method="post" id="formBankingAccountCreate" name="formBankingAccountCreate">

<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
<tr>
	<td class="frm_label">Account&nbsp;Name:</td>
	<td>
		<%= formTextBox("BankingAccountName", "40", "", "BankingElement", "Account Name", "Invalid Account Name") %>&nbsp;&nbsp;
		<%= Submit_Button("SubmitButton", "Create Account", "Button", "", "Create Account") %>&nbsp;&nbsp;
	</td>
</tr>
</table>
&nbsp;<br />

<%= formHidden("BankingID", BankingID) %>
<%= formHidden("CurrentDate", CurrentDate) %>
<%= formHidden("PreviousPage", PreviousPage) %>
<%= formHidden("Template", Template) %>
<%= formHidden("BankingAccountID", BankingAccountID) %>

</form>

<% End If %>

<% If Template = "" Then %>
	<% BankingImageID = "home" %>
	<!-- #include file="templates/home.tem" -->
<% ElseIf Template = "View" Then %>
	<!-- #include file="templates/banking_view.tem" -->
<% ElseIf Template = "BankingAccount" Then %>
	<!-- #include file="templates/BankingAccount.tem" -->
<% ElseIf Template = "ScheduledTasks" Then %>
	<!-- #include file="templates/scheduled_tasks.tem" -->
<% ElseIf Template = "view_accounts" Then %>
	<!-- #include file="templates/view_accounts.tem" -->fire
<% ElseIf Template = "daily_emails" Then %>
	<!-- #include file="templates/daily_emails.tem" -->
<% ElseIf Template = "email_blasts" Then %>
	<!-- #include file="templates/view_accounts.tem" -->
<% ElseIf Template = "banking_email" Then %>
	<!-- #include file="templates/banking_email.tem" -->
<% ElseIf Template = "banking_transactions" Then %>
	<!-- #include file="templates/banking_transactions.tem" -->
<% ElseIf Template = "Search" Then %>
	<!-- #include file="templates/search.tem" -->
<% Else %>
	<!-- #include file="templates/banking_edit.tem" -->
<% End If %>


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->	
