<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->
<%
	UserName = Trim(Request("UserName"))
	Password = Trim(Request("Password"))
	
    	sql = "SELECT * FROM Users WHERE UserName='" & SQLEncode(UserName) & "' AND Password = '" & SQLEncode(Password) & "' AND Active = 1"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)

		Session("Administrator") = null
		If ors.EOF Then
			LoginErrorMessage = "Invalid Login"
			sql = "sp_Logs_insert '" & Request.ServerVariables("SERVER_NAME") & "', 'INVALID LOGIN - USERNAME: " & UserName & ", PASSWORD: " & Password  & ", IP: " & Request.ServerVariables("REMOTE_ADDR") & ", BROWSER: " & Request.ServerVariables("HTTP_USER_AGENT") & "'"
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

			'Response.Cookies("Password") = Password
			'Response.Cookies("Password").Expires = Date + 1
			
			If PreviousPage = "" Then
				Response.Cookies("UserName") = UserName
				Response.Cookies("UserName").Expires = Date + 30
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
				
				subject = UserName & " has logged in"
				If UCase(UserName) <> "TEDDY" Then 
					SendEmail Application("AdministratorEmail"), Application("AdministratorEmail"), "", subject, subject & "<br>" & Request.ServerVariables("HTTP_USER_AGENT"), true
				End If

				Response.Redirect RedirectURL
				'Response.Redirect "users/users.asp?Login=yes&UserID=" & UserID & "&Action=Edit"
			'End If
			
		End If
%>
<!-- #include virtual="/includes/close_connection.inc" -->
