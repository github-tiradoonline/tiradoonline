<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "HomeTheme"
	PageThemeColor = HOME_THEME
	PageTitle = "Home"
	HeaderTitle = "Home"
	Response.Buffer = true	
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	reminder = CreateReminder("test subject", "test location", "4/28/2016 5:00 pm", "4/28/2016 6:00 pm")
	Call SendEmailWithAttachment("developer@tiradoonline.com", "intranet@tiradoonline.com", "", "", "", "", true)

	CreateAccountErrorMessage = Trim(Request("CreateAccountErrorMessage"))
	
	CreateAccountUserName = Trim(Request("CreateAccountUserName"))
	LoginUserName = Trim(Request("LoginUserName"))
	
	CreateAccountPassword = Trim(Request("CreateAccountPassword"))
	CreateAccountConfirmPassword = Trim(Request("CreateAccountConfirmPassword"))
	LoginPassword = Trim(Request("LoginPassword"))

	ForgotPasswordEmail = Trim(Request("ForgotPasswordEmail"))
	CreateAccountEmail = Trim(Request("CreateAccountEmail"))
	CreateAccountEmail = Trim(Request("CreateAccount_Email"))
	MobileEmail = Trim(Request("MobileEmail"))

	CreateAccountFirstName = Trim(Request("CreateAccountFirstName"))
	CreateAccountLastName = Trim(Request("CreateAccountLastName"))
	Address1 = Trim(Request("Address1"))
	Address2 = Trim(Request("Address2"))
	City = Trim(Request("City"))
	StateID = Trim(Request("StateID"))
	If StateID = "" Then StateID = Application("StateID")
	ZipCode = Trim(Request("ZipCode"))
	Phone = Trim(Request("Phone"))

	AIM = Trim(Request("AIM"))
	Hotmail = Trim(Request("Hotmail"))
	Yahoo = Trim(Request("Yahoo"))
	Skype = Trim(Request("Skype"))
	Gmail = Trim(Request("Gmail"))

	If SubmitButton = "Save Account" Then
		sql = "UPDATE Users SET " & _
				"UserName = '" & SQLEncode(CreateAccountUserName) & "', " & _
				"Password = '" & SQLEncode(CreateAccountPassword) & "', " & _
				"FirstName = '" & SQLEncode(CreateAccountFirstName) & "', " & _
				"LastName = '" & SQLEncode(CreateAccountLastName) & "', " & _
				"Email = '" & CreateAccountEmail & "', " & _
				"MobileEmail = '" & MobileEmail & "', " & _
				"Address1 = '" & SQLEncode(Address1) & "', " & _
				"Address2 = '" & SQLEncode(Address2) & "', " & _
				"City = '" & SQLEncode(City) & "', " & _
				"StateID = " & StateID & ", " & _
				"ZipCode = '" & SQLEncode(ZipCode) & "', " & _
				"Phone = dbo.fn_FormatPhoneNumber('" & SQLEncode(Phone) & "'), " & _
				"AIM = '" & SQLEncode(AIM) & "', " & _
				"Yahoo = '" & SQLEncode(Yahoo) & "', " & _
				"Hotmail = '" & SQLEncode(Hotmail) & "', " & _
				"Skype = '" & SQLEncode(Skype) & "', " & _
				"Gmail = '" & SQLEncode(Gmail) & "', " & _
				"update_by = '" & Session("UserName") & "', " & _
				"update_dt = getdate() " & _
				"WHERE UserID = " & Session("UserID")
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		ErrorMessage = Server.URLEncode("Account saved.")
		Response.Redirect SCRIPT_NAME & "?ErrorMessage=" & ErrorMessage
	End If
%>
<!-- #include virtual="/includes/open_header.inc" -->


<!-- 
*****************************
 -->
<% If ErrorMessage <> "" Then %><div class="ErrorMessage"><%= ErrorMessage %></div><% End If %>
<table cellpadding="5" border="0">
<tr>
	<td class="frm_label">IP&nbsp;ADDRESS:</td>
	<td width="100%">
		<b><%= Request.ServerVariables("REMOTE_ADDR") %></b>
	</td>
</tr>
<tr>
	<td class="frm_label">SERVER&nbsp;NAME:</td>
	<td>
		<b><%= Request.ServerVariables("SERVER_NAME") %></b>
	</td>
</tr>
<tr>
	<td colspan="2">	
	<%
		SubmitButtonValue = "Save"
		
		sql = "SELECT * FROM Users WHERE UserID = " & Session("UserID")
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then	
			CreateAccountUserName = ors("UserName")
			CreateAccountPassword = ors("Password")
			CreateAccountConfirmPassword = 	CreateAccountPassword
			CreateAccountFirstName = ors("FirstName")
			CreateAccountLastName = ors("LastName")
			CreateAccount_Email = ors("Email")
			Phone = ors("Phone")
			AIM = ors("AIM")
			Hotmail = ors("Hotmail")
			Yahoo = ors("Yahoo")
			Skype = ors("Skype")
			Gmail = ors("Gmail")
			MobileEmail = ors("MobileEmail")
			Address1 = ors("Address1")
			Address2 = ors("Address2")
			City = ors("City")
			StateID = ors("StateID")
			StateName = ""
			If isNull(StateID) Then StateID = Application("StateID")
			ZipCode = ors("ZipCode")
		
			sql = "SELECT StateAbbr FROM States WHERE StateID = " & StateID
			Set ors2 = oConn.Execute(sql)
			If NOT ors2.EOF Then
				StateName = ors2.Fields(0).Value
				ors2.Close
			End If
			
			If Address1 <> "" AND City <> "" AND StateName <> "" AND ZipCode <> "" Then
				Address = Address1 & " " & City & ", " & StateName & " " & ZipCode
			End If
			
			ors.Close
		End If
		Set ors = Nothing
	%>
		<form action="<%= SCRIPT_NAME %>" method="post" id="formCreateAccount" name="formCreateAccount">
		<!-- #include virtual="/includes/forms/account.inc" -->
		</form>
		
	</td>
</tr>
</table>

<!-- 
******************************
 -->

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
