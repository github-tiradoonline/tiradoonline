<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="icon" type="image/ico" href="/images/icons/logo.ico" /> 
	<link rel="shortcut icon" href="/images/icons/logo.ico" />
	<title><%= Application("ApplicationName") %></title>

    <link href="/includes/foundation/css/foundation.css" rel="stylesheet" />
    <script src="/includes/foundation/js/vendor/modernizr.js" type="text/javascript"></script>

    <script src="/includes/jquery/jquery.js" type="text/javascript"></script>
	

<style type="text/css">


	body {
		font-family : Cambria;
		padding: 0px;
		margin: 0px;
    	background-repeat: no-repeat;
	    background-attachment: fixed;
    	background-position: center; 
		background-image: url('/images/background/logo.gif');	
		/*background-size: 90% 90%;*/
	}

	.ErrorMessage {
		font-weight: bold;
		color: #ff0000;
	}
	
	<%
		loginWidth = 208
		loginHeight = 320
	%>
	#loginBox {
		position: fixed;
		top: 50%;
		left: 50%;
		margin-top: -<%= loginHeight / 2 %>px;
		margin-left: -<%= (loginWidth / 2) - 35 %>px;
	}

	#loginForm {
		width: <%= loginWidth %>px;
		height: <%= loginHeight %>px;
	}
	
	#loginUserName, #loginPassword {
		background: rgba(255, 255, 255, 0);
		color: #000;
		border: 0px solid #fff;
	}
	
	::-webkit-input-placeholder { /* WebKit browsers */
		background: rgba(255, 255, 255, 0);
    	color: #000;
		border: 0px solid #fff;
	}

	:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
		background: rgba(255, 255, 255, 0);
    	color: #000;
		border: 0px solid #fff;
	}

	::-moz-placeholder { /* Mozilla Firefox 19+ */
		background: rgba(255, 255, 255, 0);
    	color: #000;
		border: 0px solid #fff;
	}

	:-ms-input-placeholder { /* Internet Explorer 10+ */
    	color: #000;
		border: 0px solid #fff;
	}

</style>
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">

<%
	Response.ExpiresAbsolute = Date - 1
	PageThemeColor = Application("ThemeColor")
	If Session("UserID") = "" Then UserID = Session("DefaultUserID")	
	Title = "tiradoonline.com login"

	LoginErrorMessage = Trim(Request("LoginErrorMessage"))
	ForgotPasswordErrorMessage = Trim(Request("ForgotPasswordErrorMessage"))
	CreateAccountErrorMessage = Trim(Request("CreateAccountErrorMessage"))
	
	CreateAccountUserName = Trim(Request("CreateAccountUserName"))
	LoginUserName = Trim(Request("LoginUserName"))
	
	CreateAccountPassword = Trim(Request("CreateAccountPassword"))
	CreateAccountConfirmPassword = Trim(Request("CreateAccountConfirmPassword"))
	LoginPassword = Trim(Request("LoginPassword"))

	ForgotPassword_Email = Trim(Request("ForgotPassword_Email"))
	CreateAccount_Email = Trim(Request("CreateAccount_Email"))
	Email = Trim(Request("Email"))

	CreateAccountFirstName = Trim(Request("CreateAccountFirstName"))
	CreateAccountLastName = Trim(Request("CreateAccountLastName"))

	SelectedTab = Trim(Request("SelectedTab"))
	If SelectedTab = "" Then SelectedTab = "0"

	UserTypeID = Trim(Request("UserTypeID"))
	If UserTypeID = "" Then UserTypeID = "0"
	
	Email = Trim(Request("Email"))
	MobileEmail = Trim(Request("MobileEmail"))

	Contacts = Trim(Request("Contacts"))
	If Contacts = "" Then Contacts = "0"

	Documents = Trim(Request("Documents"))
	If Documents = "" Then Documents = "0"

	PersonalInformation = Trim(Request("PersonalInformation"))
	If PersonalInformation = "" Then PersonalInformation = "0"

	Banking = Trim(Request("Banking"))
	If Banking = "" Then Banking = "0"

	CreditCards = Trim(Request("CreditCards"))
	If CreditCards = "" Then CreditCards = "0"

	MonthlyExpenses = Trim(Request("MonthlyExpenses"))
	If MonthlyExpenses = "" Then MonthlyExpenses = "0"

	CollectionAgency = Trim(Request("CollectionAgency"))
	If CollectionAgency = "" Then CollectionAgency = "0"

	Photos = Trim(Request("Photos"))
	If Photos = "" Then Photos = "0"

	Music = Trim(Request("Music"))
	If Music = "" Then Music = "0"

	MovieCollection = Trim(Request("MovieCollection"))
	If MovieCollection = "" Then MovieCollection = "0"

	Movies = Trim(Request("Movies"))
	If Movies = "" Then Movies = "0"

	Snippets = Trim(Request("Snippets"))
	If Snippets = "" Then Snippets = "0"

	Health = Trim(Request("Health"))
	If Health = "" Then Health = "0"

	Jobs = Trim(Request("Jobs"))
	If Jobs = "" Then Jobs = "0"

	Recovery = Trim(Request("Recovery"))
	If Recovery = "" Then Recovery = "0"

	Notes = Trim(Request("Notes"))
	If Notes = "" Then Notes = "0"

	Timesheet = Trim(Request("Timesheet"))
	If Timesheet = "" Then Timesheet = "0"

	Notes = Trim(Request("Notes"))
	If Notes = "" Then Notes = "0"

	ServerInformation = Trim(Request("ServerInformation"))
	If ServerInformation = "" Then ServerInformation = "0"

	tiradoonline = Trim(Request("tiradoonline"))
	If tiradooline = "" Then tiradoonline = "0"

	If SubmitButton = "" Then
		LoginUserName = Request.Cookies("LoginUserName")
	End If
	
	If SubmitButton = "Logout" Then
		oConn.Close
		Set oConn = Nothing
		Session.Abandon
		Response.Redirect SCRIPT_NAME
	End If
		
	If SubmitButton = "LOGIN" OR SubmitButton = "LoginAs" Then
		If Trim(Request("UserID")) <> "" Then
			sql = "SELECT * FROM Users WHERE UserID = " & Trim(Request("UserID"))
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				LoginUserName = ors("UserName")
				LoginPassword = ors("Password")
				Response.Cookies("LoginUserName") = ""
				Response.Cookies("LoginPassword") = ""
				ors.Close
			End If
			Set ors = Nothing
		End If
		
		
    	sql = "SELECT * FROM Users WHERE UserName='" & SQLEncode(LoginUserName) & "' AND Password = '" & SQLEncode(LoginPassword) & "' AND Active = 1"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)

		Session("Administrator") = null
		If ors.EOF Then
			LoginErrorMessage = "Invalid Login"
			sql = "sp_Logs_insert '" & Request.ServerVariables("SERVER_NAME") & "', 'INVALID LOGIN - USERNAME: " & LoginUserName & ", PASSWORD: " & LoginPassword  & ", IP: " & Request.ServerVariables("REMOTE_ADDR") & ", BROWSER: " & Request.ServerVariables("HTTP_USER_AGENT") & "'"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			
		Else
			Session("LoginUserID") = ""
			UserID = ors("UserID")
			Email = ors("Email")
			Administrator = ors("UserTypeID")
			Contacts = ors("Contacts")
			PersonalInformation = ors("PersonalInformation")
			Banking = ors("Banking")
			Documents = ors("Documents")
			CreditCards = ors("CreditCards")
			MonthlyExpenses = ors("MonthlyExpenses")
			CollectionAgency = ors("CollectionAgency")
			Photos = ors("Photos")
			Music = ors("Music")
			MovieCollection = ors("MovieCollection")
			Movies = ors("Movies")
			Snippets = ors("Snippets")
			Health = ors("Health")
			Jobs = ors("Jobs")
			Recovery = ors("Recovery")
			Timesheet = ors("Timesheet")
			ServerInformation = ors("ServerInformation")
			Notes = ors("Notes")
			tiradoonline = ors("tiradoonline")

			Session("Email") = Email
			Session("UserName") = UserName
			Session("UserID") = UserID
			Session("Administrator") = Administrator
			Session("FullName") = ors("FirstName") & " " & ors("LastName")
			Session("Contacts") = Contacts
			Session("MonthlyExpenses") = MonthlyExpenses
			Session("CollectionAgency") = CollectionAgency
			Session("PersonalInformation") = PersonalInformation
			Session("Banking") = Banking
			Session("Documents") = Documents
			Session("CreditCards") = CreditCards
			Session("Photos") = Photos
			Session("Music") = Music
			Session("MovieCollection") = MovieCollection
			Session("Movies") = Movies
			Session("Snippets") = Snippets
			Session("Health") = Health
			Session("Jobs") = Jobs
			Session("Recovery") = Recovery
			Session("Timesheet") = Timesheet
			Session("Notes") = Notes
			Session("ServerInformation") = ServerInformation
			Session("tiradoonline") = tiradoonline

			'Response.Cookies("LoginPassword") = LoginPassword
			'Response.Cookies("LoginPassword").Expires = Date + 1
			
			If PreviousPage = "" Then
				Response.Cookies("LoginUserName") = LoginUserName
				Response.Cookies("LoginUserName").Expires = Date + 30
				Session("Administrator") = Administrator
			End If

			sql = "sp_Logins_insert " & _
				  UserID & ", " & _
				  "'" & Request.ServerVariables("HTTP_USER_AGENT") & "', " & _
				  "'" & Request.ServerVariables("REMOTE_ADDR") & "'"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
    	    isMobile = false
		    if Request.ServerVariables("http_x_wap_profile") <> "" then isMobile = true
		    
			'If isMobile Then
			'    Session("isMobile") = true
			'	Response.Redirect "/mobile"
			'Else
				sql = "sp_Settings_get " & UserID
				Set ors = oConn.Execute(sql)
				If NOT ors.EOF Then
					vPreviousPage = ors("PreviousPage")
					ors.Close
				End If
				Set ors = Nothing
				
				'Response.Write InStr(UCase(vPreviousPage), "DEFAULT.ASP")
				If vPreviousPage <> "" AND NOT isNull(vPreviousPage) AND InStr(UCase(vPreviousPage), "DEFAULT.ASP") < 1 Then
				'If vPreviousPage <> "" AND NOT isNull(vPreviousPage) Then
					RedirectURL = vPreviousPage
				Else
					RedirectURL = "/home.asp?ErrorMessage=" & Server.URLEncode(ErrorMessage)
				End If
				
				subject = LoginUserName & " has logged in"
				If UCase(LoginUserName) <> "TEDDY" Then 
					SendEmail Application("AdministratorEmail"), Application("AdministratorEmail"), "", subject, subject & "<br>" & Request.ServerVariables("HTTP_USER_AGENT"), true
				End If

				Response.Redirect RedirectURL
				'Response.Redirect "users/users.asp?Login=yes&UserID=" & UserID & "&Action=Edit"
			'End If
			
		End If
	ElseIf SubmitButton = "Forgot Password" Then
    	sql = "SELECT * FROM Users WHERE Email='" & SQLEncode(ForgotPassword_Email) & "' AND Active = 1"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)

		If ors.EOF Then
			ForgotPasswordErrorMessage = "Email Address: '" & ForgotPassword_Email & "' not found."
			sql = "sp_Logs_insert '" & Request.ServerVariables("SERVER_NAME") & "', '" & SQLEncode(Email) & "'"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
		Else
			v_UserName = ors("UserName")
			v_Password = ors("Password")
			
			sql = "sp_Settings_get " & Session("DefaultUserID")
			WriteDebugger sql, Debugging, 0
			Set orsSettings = oConn.Execute(sql)
			If NOT orsSettings.EOF Then
				AdministratorEmail = orsSettings("AdministratorEmail")
				orsSettings.Close
			End If
			Set orsSettings = Nothing
			
			sql = "sp_EmailTemplates_get " & Session("DefaultUserID")
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				Subject = ors("ForgotPasswordSubject")
				BodyText = ors("ForgotPasswordEmail")
				BodyText = Replace(BodyText, "###USERNAME###", v_UserName)
				BodyText = Replace(BodyText, "###PASSWORD###", v_Password)
				BodyText = "<pre>" & BodyText & "</pre>"
				ors.Close
			End If
			Set ors = Nothing

			SendEmail ForgotPassword_Email, AdministratorEmail, AdministratorEmail, Subject, BodyText, 1
			ErrorMessage = "Login information emailed to: '" & ForgotPassword_Email & "'"
			
			Response.Redirect SCRIPT_NAME & "?LoginErrorMessage=" & Server.URLEncode(ErrorMessage)
			
			ors.Close
		End If
		Set ors = Nothing
	ElseIf SubmitButton = "Create Account" Then
		AccountExists = false

    	sql = "SELECT * FROM Users WHERE UserName='" & SQLEncode(CreateAccountUserName) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)

		If ors.EOF Then
	    	sql = "SELECT * FROM Users WHERE Email='" & SQLEncode(CreateAccount_Email) & "'"
			WriteDebugger sql, Debugging, 0
			Set ors2 = oConn.Execute(sql)
			If NOT ors2.EOF Then
				CreateAccountErrorMessage = "Email: '" & CreateAccount_Email & "' exists."
				ors2.Close
				AccountExists = true
				CreateAccount_Email = ""
			End If
			Set ors2 = Nothing
		Else
			ors.Close
			CreateAccountErrorMessage = "Username: '" & CreateAccountUserName & "' exists."
			AccountExists = true
			CreateAccountUserName = ""
		End If
		Set ors = Nothing
		
		If NOT AccountExists Then
			sql = "sp_Users_insert " & _
					"'" & CreateAccountUserName & "', " & _
					"'" & CreateAccountPassword & "', " & _
					"'" & CreateAccountFirstName & "', " & _
					"'" & CreateAccountLastName & "', " & _
					"'" & CreateAccount_Email & "', " & _
					"'" & MobileEmail & "', " & _
					UserTypeID & ", " & _
					Contacts & ", " & _ 
					PersonalInformation & ", " & _ 
					Documents & ", " & _ 
					Banking & ", " & _ 
					CreditCards & ", " & _ 
					MonthlyExpenses & ", " & _ 
					CollectionAgency & ", " & _ 
					Photos & ", " & _ 
					Music & ", " & _ 
					MovieCollection & ", " & _ 
					Movies & ", " & _ 
					Snippets & ", " & _ 
					Health & ", " & _ 
					Jobs & ", " & _ 
					Recovery & ", " & _ 
					Timesheet & ", " & _ 
					Notes & ", " & _ 
					ServerInformation & ", " & _ 
					tiradoonline
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				UserID = ors("UserID")
				ors.Close
			End If
			Set ors = Nothing

			sql = "sp_Settings_get " & Session("DefaultUserID")
			WriteDebugger sql, Debugging, 0
			Set orsSettings = oConn.Execute(sql)
			If NOT orsSettings.EOF Then
				AdministratorEmail = orsSettings("AdministratorEmail")
				orsSettings.Close
			End If
			Set orsSettings = Nothing
			
			sql = "sp_EmailTemplates_get " & Session("DefaultUserID")
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				Subject = ors("CreateAccountSubject")
				BodyText = ors("CreateAccountEmail")
				BodyText = Replace(BodyText, "###FIRSTNAME###", CreateAccountFirstName)
				BodyText = Replace(BodyText, "###LASTNAME###", CreateAccountLastName)
				BodyText = Replace(BodyText, "###USERNAME###", CreateAccountUserName)
				BodyText = Replace(BodyText, "###PASSWORD###", CreateAccountPassword)
				BodyText = "<pre>" & BodyText & "</pre>"
				ors.Close
			End If
			Set ors = Nothing
			'Response.Write BodyText
			SendEmail CreateAccount_Email, AdministratorEmail, AdministratorEmail, Subject, BodyText, 1
			ErrorMessage = "Account created."
			RedirectURL = SCRIPT_NAME & "?SubmitButton=Login&LoginUserName=" & Server.URLEncode(CreateAccountUserName) & "&LoginPassword=" & Server.URLEncode(CreateAccountPassword) & "&ErrorMessage=" & Server.URLEncode(ErrorMessage)
			Response.Redirect RedirectURL
		Else
			SelectedTab = 2
		End If
	End If
%>

<!-- #include virtual="/includes/local.inc" -->



<form action="<%= SCRIPT_NAME %>" method="post">

	<div id="loginBox" style="display:none">
	
		<div id="loginForm">
		
			<div style="text-align: center">
				<img src="/images/login/lock.gif" alt="<%= Application("Application") %>" border="0" >
			</div>

		<% If LoginErrorMessage <> "" Then %>
			<div class="ErrorMessage"><%= LoginErrorMessage %></div>
		<% End If %>
			<input type="text" id="LoginUserName" name="LoginUserName" value="<%= LoginUserName %>" placeholder="Username" errormessage="Invalid Username" />

			<input type="password" id="LoginPassword" name="LoginPassword" placeholder="Password" errormessage="Invalid Password" />

			<input type="submit" id="SubmitButton" name="SubmitButton" class="button small expand" value="LOGIN">
			
		</div>

	</div>
	
</form>

<script type="text/javascript">

	function loadLogin()
	{
	    $('#loginBox').fadeIn(2000);
	}

	setTimeout("loadLogin()", 1000);

</script>

</body>
</html>
<!-- #include virtual="/includes/close_connection.inc" -->
