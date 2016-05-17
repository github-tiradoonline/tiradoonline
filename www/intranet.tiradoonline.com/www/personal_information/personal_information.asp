<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "personalInformationTheme"
	PageTitle = "Personal Information"
	PageThemeColor = PERSONAL_INFORMATION_THEME
	HeaderTitle = "Personal&nbsp;Information"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	Letter = Trim(Request("Letter"))
	PersonalInformationID =  Trim(Request("PersonalInformationID"))
	AccountName =  Trim(Request("AccountName"))
	RegistrationDate  =  Trim(Request("RegistrationDate"))
	If RegistrationDate = "" Then RegistrationDate = Date
	UserName  =  Trim(Request("UserName"))
	Password  =  Trim(Request("Password"))
	Password2  =  Trim(Request("Password2"))
	Website  =  Trim(Request("Website"))
	AccountNumber  =  Trim(Request("AccountNumber"))
	AccountNumber2  =  Trim(Request("AccountNumber2"))
	Rewards  =  Trim(Request("Rewards"))
	Phone  =  Trim(Request("Phone"))
	Phone2  =  Trim(Request("Phone2"))
	Email =  Trim(Request("Email"))
	ATM  =  Trim(Request("ATM"))
	Pin = Trim(Request("Pin"))
	Checking  =  Trim(Request("Checking"))
	RoutingNumber  =  Trim(Request("RoutingNumber"))
	CCTypeID  =  Trim(Request("CCTypeID"))
	If CCTypeID = "" Then CCTypeID = 1002
	Expiration  =  Trim(Request("Expiration"))
	CSV  =  Trim(Request("CSV"))

	SerialNumber =  Trim(Request("SerialNumber"))
	Code  =  Trim(Request("Code"))
	Notes =  Trim(Request("Notes"))
	SubmitButtonValue = "Create"
	If PersonalInformationID <> "" Then SubmitButtonValue = "Save"
	If SubmitButton = "Create" Then
		sql = "INSERT INTO PersonalInformation (" & _
		"UserID, " & _
		"AccountName, " & _
		"RegistrationDate, " & _
		"UserName, " & _
		"Password, " & _
		"Password2, " & _
		"Website, " & _
		"AccountNumber, " & _
		"AccountNumber2, " & _
		"Rewards, " & _
		"Phone, " & _
		"Phone2, " & _
		"Email, " & _
		"ATM, " & _
		"Pin, " & _
		"Checking, " & _
		"RoutingNumber, " & _
		"CCTypeID, " & _
		"Expiration, " & _
		"CSV, " & _
		"SerialNumber, " & _
		"Code, " & _
		"Notes, " & _
		"Browser) VALUES (" & _
		Session("UserID") & ", " & _
		"'" & SQLEncode(AccountName) & "', " & _
		"'" & SQLEncode(RegistrationDate) & "', " & _
		"'" & SQLEncode(UserName) & "', " & _
		"'" & SQLEncode(Password) & "', " & _
		"'" & SQLEncode(Password2) & "', " & _
		"'" & SQLEncode(Website) & "', " & _
		"'" & SQLEncode(AccountNumber) & "', " & _
		"'" & SQLEncode(AccountNumber2) & "', " & _
		"'" & SQLEncode(Rewards) & "', " & _
		"dbo.fn_FormatPhoneNumber('" & SQLEncode(Phone) & "'), " & _
		"dbo.fn_FormatPhoneNumber('" & SQLEncode(Phone2) & "'), " & _
		"'" & SQLEncode(Email) & "', " & _
		"'" & SQLEncode(ATM) & "', " & _
		"'" & SQLEncode(Pin) & "', " & _
		"'" & SQLEncode(Checking) & "', " & _
		"'" & SQLEncode(RoutingNumber) & "', " & _
		SQLEncode(CCTypeID) & ", " & _
		"'" & SQLEncode(Expiration) & "', " & _
		"'" & SQLEncode(CSV) & "', " & _
		"'" & SQLEncode(SerialNumber) & "', " & _
		"'" & SQLEncode(Code) & "', " & _
		"'" & SQLEncode(Notes) & "', " & _
		"'" & SQLEncode(Request.ServerVariables("HTTP_USER_AGENT")) & "')"
		
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		PersonalInformationErrorMessage = Server.URLEncode("Account: " & AccountName & " created")
		Response.Redirect SCRIPT_NAME & "?Template=View" & "&Letter=" & Left(AccountName, 1) & "&PersonalInformationErrorMessage=" & PersonalInformationErrorMessage
	ElseIf SubmitButton = "Save" Then
		sql = "UPDATE PersonalInformation SET " & _
		"AccountName = '" & SQLEncode(AccountName) & "', "
		sql = sql & "RegistrationDate  = '" & SQLEncode(RegistrationDate) & "', "
		'If RegistrationDate <> "" Then sql = sql & "RegistrationDate  = '" & SQLEncode(RegistrationDate) & "', "
		sql = sql & "UserName  = '" & SQLEncode(UserName) & "', " & _
		"Password  = '" & SQLEncode(Password) & "', " & _
		"Password2  = '" & SQLEncode(Password2) & "', " & _
		"Website  = '" & SQLEncode(Website) & "', " & _
		"AccountNumber  = '" & SQLEncode(AccountNumber) & "', " & _
		"AccountNumber2  = '" & SQLEncode(AccountNumber2) & "', " & _
		"Rewards  = '" & SQLEncode(Rewards) & "', " & _
		"Phone  = dbo.fn_FormatPhoneNumber('" & SQLEncode(Phone) & "'), " & _
		"Phone2  = dbo.fn_FormatPhoneNumber('" & SQLEncode(Phone2) & "'), " & _
		"Email  = '" & SQLEncode(Email) & "', " & _
		"ATM  = '" & SQLEncode(ATM) & "', " & _
		"Pin = '" & SQLEncode(Pin) & "', " & _
		"Checking  = '" & SQLEncode(Checking) & "', " & _
		"RoutingNumber  = '" & SQLEncode(RoutingNumber) & "', " & _
		"CCTypeID  = " & SQLEncode(CCTypeID) & ", " & _
		"Expiration  = '" & SQLEncode(Expiration) & "', " & _
		"CSV  = '" & SQLEncode(CSV) & "', " & _
		"SerialNumber = '" & SQLEncode(SerialNumber) & "', " & _
		"Code  = '" & SQLEncode(Code) & "', " & _
		"Notes = '" & SQLEncode(Notes) & "' " & _
		"WHERE PersonalInformationID = " & SQLEncode(PersonalInformationID)
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute sql
		PersonalInformationErrorMessage = Server.URLEncode("Account: " & AccountName & " settings saved")
		Response.Redirect SCRIPT_NAME & "?Letter=" & UCase(Left(AccountName, 1)) & "&Template=View&PersonalInformationErrorMessage=" & PersonalInformationErrorMessage
	ElseIf SubmitButton = "Delete" Then
		sql = "UPDATE PersonalInformation SET Active = 0 WHERE PersonalInformationID = " & PersonalInformationID
		oConn.Execute sql
		PersonalInformationErrorMessage = Server.URLEncode("Account deleted")
		Response.Redirect SCRIPT_NAME & "?Template=View" & "&Letter=" & Left(AccountName, 1) & "&PersonalInformationErrorMessage=" & PersonalInformationErrorMessage & "&Letter="& Left(AccountName, 1)
	Else
		SelectedTab = 0
	
		UserName = ""
		Password = ""
	End If 
%>

<!-- #include virtual="/includes/open_header.inc" -->

<form action="<%= SCRIPT_NAME %>" method="post" id="formPersonalInformation" name="formPersonalInformation">

		<p>
		
					<%= Button("Button", "Create New Account", "Button", "", "Create New Account", "location.href='" & SCRIPT_NAME & "'") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<% If PersonalInformationErrorMessage <>  "" Then %><div class="ErrorMessage"><%= PersonalInformationErrorMessage %></div><% End If %>
		<% If Template = "View" Then %>
			<!-- #include file="templates/view_personalinformation.tem" -->
		<% Else %>
			<!-- #include file="templates/edit_personalinformation.tem" -->
		<% End If %>

</form>
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->

