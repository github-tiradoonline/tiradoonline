<%
	Debugging = false
	MainContentWidth = 500
	'Response.Write Session.Timeout
	If LCase(Request.ServerVariables("SERVER_NAME")) = "intranet.tiradoonline.com" Then
		MachineName = ".\SQL2k8"
		MachineName = ".\SQL2k12"
	Else
		MachineName = ".\SQL2K12"
		MachineName = ".\SQL2K12"
	End If
	'Response.Write MachineName
	'Response.End
	
	If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
		If Instr(UCase(Request.ServerVariables("SCRIPT_NAME")), "BANKING.ASP") > 0 Then
			BankingUploadsDirectory = Session("BankingUploadsDirectory")
		    Set Upload = New FreeASPUpload
			Upload.Save(BankingUploadsDirectory)
		ElseIf Instr(UCase(Request.ServerVariables("SCRIPT_NAME")), "JOBS.ASP") > 0 Then
			ResumeUploadsDirectory = Session("ResumeUploadsDirectory")
		    Set Upload = New FreeASPUpload
			Upload.Save(ResumeUploadsDirectory)
		End If
		
		Action = Trim(Upload.Form("Action"))

		'*********** ERRROR MESSAGES ***********************
		ErrorMessage = Trim(Upload.Form("ErrorMessage"))
		AdministrationErrorMessage = Trim(Upload.Form("AdministrationErrorMessage"))
		ContactsErrorMessage = Trim(Upload.Form("ContactsErrorMessage"))
		PersonalInformationErrorMessage = Trim(Upload.Form("PersonalInformationErrorMessage"))
		DocumentsErrorMessage = Trim(Upload.Form("DocumentsErrorMessage"))
		BankingErrorMessage = Trim(Upload.Form("BankingErrorMessage"))
		CreditCardsErrorMessage = Trim(Upload.Form("CreditCardsErrorMessage"))
		PhotosErrorMessage = Trim(Upload.Form("PhotosErrorMessage"))
		MusicErrorMessage = Trim(Upload.Form("MusicErrorMessage"))
		MovieCollectionErrorMessage = Trim(Upload.Form("MovieCollectionErrorMessage"))
		MoviesErrorMessage = Trim(Upload.Form("MoviesErrorMessage"))
		SnippetsErrorMessage = Trim(Upload.Form("SnippetsErrorMessage"))
		HealthErrorMessage = Trim(Upload.Form("HealthErrorMessage"))
		JobsErrorMessage = Trim(Upload.Form("JobsErrorMessage"))
		RecoveryErrorMessage = Trim(Upload.Form("RecoveryErrorMessage"))
		TimesheetErrorMessage = Trim(Upload.Form("TimesheetErrorMessage"))	
		tiradoonlineErrorMessage = Trim(Upload.Form("tiradoonlineErrorMessage"))
		NotesErrorMessage = Trim(Upload.Form("NotesErrorMessage"))
		SettingsErrorMessage = Trim(Upload.Form("SettingsErrorMessage"))
		ProfileErrorMessage = Trim(Upload.Form("ProfileErrorMessage"))
		'***************************************************
		SubmitButton = Trim(Upload.Form("SubmitButton"))
		Template = Trim(Upload.Form("Template"))
	
	Else
		Action = Trim(Request("Action"))

		'*********** ERRROR MESSAGES ***********************
		ErrorMessage = Trim(Request("ErrorMessage"))
		AdministrationErrorMessage = Trim(Request("AdministrationErrorMessage"))
		ContactsErrorMessage = Trim(Request("ContactsErrorMessage"))
		PersonalInformationErrorMessage = Trim(Request("PersonalInformationErrorMessage"))
		DocumentsErrorMessage = Trim(Request("DocumentsErrorMessage"))
		BankingErrorMessage = Trim(Request("BankingErrorMessage"))
		CreditCardsErrorMessage = Trim(Request("CreditCardsErrorMessage"))
		PhotosErrorMessage = Trim(Request("PhotosErrorMessage"))
		MusicErrorMessage = Trim(Request("MusicErrorMessage"))
		MovieCollectionErrorMessage = Trim(Request("MovieCollectionErrorMessage"))
		MoviesErrorMessage = Trim(Request("MoviesErrorMessage"))
		SnippetsErrorMessage = Trim(Request("SnippetsErrorMessage"))
		HealthErrorMessage = Trim(Request("HealthErrorMessage"))
		JobsErrorMessage = Trim(Request("JobsErrorMessage"))
		RecoveryErrorMessage = Trim(Request("RecoveryErrorMessage"))
		TimesheetErrorMessage = Trim(Request("TimesheetErrorMessage"))
		tiradoonlineErrorMessage = Trim(Request("tiradoonlineErrorMessage"))
		NotesErrorMessage = Trim(Request("NotesErrorMessage"))
		SettingsErrorMessage = Trim(Request("SettingsErrorMessage"))
		ProfileErrorMessage = Trim(Request("ProfileErrorMessage"))

		'***************************************************
		SubmitButton = Trim(Request("SubmitButton"))
		Template = Trim(Request("Template"))
	
	End If
	
	BANNER = "<img src=""/images/header/banner.gif"" title=""tiradoonline.com"" hspace=""0"" vspace=""0"" border=""0"">"
	changeTextAreaHeight = 1000
	changeTextAreaWidth = 200
	
	SERVER_NAME = Request.ServerVariables("SERVER_NAME")
	ADD_ICON = "<img src=""/images/icons/add.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	ADD_SMALL_ICON = "<img src=""/images/icons/add_small.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	AIM_ICON = "<img src=""/images/icons/aim.gif"" title=""AIM"" hspace=""0"" vspace=""0"" border=""0"">"
	DOWN_ICON = "<img src=""/images/icons/down.gif"" title=""Down"" hspace=""0"" vspace=""0"" border=""0"">"
	DELETE_ICON = "<img src=""/images/icons/delete.gif"" title=""Delete"" hspace=""0"" vspace=""0"" border=""0"">"
	EMAIL_ICON = "<img src=""/images/icons/email.gif"" title=""Email"" hspace=""0"" vspace=""0"" border=""0"">"
	EDIT_ICON = "<img src=""/images/icons/edit.gif"" title=""Email"" hspace=""0"" vspace=""0"" border=""0"">"
	FACEBOOK_ICON = "<img src=""/images/icons/facebook.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	FIREFOX_ICON = "<img src=""/images/icons/firefox.gif"" width=""16"" height=""16"" hspace=""0"" vspace=""0"" border=""0"">"
	GMAIL_ICON = "<img src=""/images/chat_icons/gmail.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	GOOGLEPLUS_ICON = "<img src=""/images/icons/google_plus.gif"" width=""17"" height=""17"" hspace=""0"" vspace=""0"" border=""0"">"
	HOTMAIL_ICON = "<img src=""/images/icons/hotmail.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	INSTAGRAM_ICON = "<img src=""/images/icons/instagram.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	LINKEDIN_ICON = "<img src=""/images/icons/linkedin.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	LOGO = "<img src=""/images/logo/logo.gif"" title=""Bankingintranet.tiradoonline.com"" hspace=""0"" vspace=""0"" border=""0"">"
	LOGO_BANNER = "<img src=""/images/header/logo_banner.gif"" title=""Bankingintranet.tiradoonline.com"" hspace=""0"" vspace=""0"" border=""0"">"
	MAP_ICON = "<img src=""/images/icons/map.gif"" width=""15"" height=""24"" hspace=""0"" vspace=""0"" border=""0"">"
	NOTEPAD_ICON = "<img src=""http://" & SERVER_NAME & "/images/icons/notepad.gif"" width=""14"" height=""17"" hspace=""0"" vspace=""0"" border=""0"">"
	PINTEREST_ICON = "<img src=""/images/icons/pinterest.jpg"" hspace=""0"" vspace=""0"" border=""0"">"
	PREVIEW_ICON = "<img src=""/images/icons/preview.jpg"" hspace=""0"" vspace=""0"" border=""0"">"
	PRINT_ICON = "<img src=""/images/icons/print.jpg"" hspace=""0"" vspace=""0"" border=""0"">"
	REQUIRED_ICON = "<img src=""/images/icons/required.gif"" title=""Required"" style=""padding-left:5px"">"
	SCRIPT_NAME = Request.ServerVariables("SCRIPT_NAME")
	SKYPE_ICON = "<img src=""/images/icons/skype.gif"" title=""Skype"">"
	TWITTER_ICON = "<img src=""/images/icons/twitter.jpg"" hspace=""0"" vspace=""0"" border=""0"">"
	UP_ICON = "<img src=""/images/icons/up.gif"" title=""uP"" hspace=""0"" vspace=""0"" border=""0"">"
	X_ICON = "<img src=""/images/icons/x.gif"" id=""X_ICON"" name=""X_ICON"" title=""Delete"" width=""16"" height=""16"" hspace=""5"" vspace=""0"" border=""0"">"
	YAHOO_ICON = "<img src=""/images/icons/yahoo.gif"" hspace=""0"" vspace=""0"" border=""0"">"
	YOUTUBE_ICON = "<img src=""/images/icons/youtube.jpg"" width=""17"" height=""17"" hspace=""0"" vspace=""0"" border=""0"">"
	
	ADMINISTRATION_THEME = "#FF0000"
	BANKING_THEME = "#4BCC4B"
	BANKING_MONTHLY_EXPENSES_THEME = "#E9B41A"
	BANKING_SUB_THEME = "#639a63"
	CALENDAR_THEME = "ORANGE"
	COLLECTION_AGENCY_THEME = "BROWN"
	CONTACTS_THEME = "PURPLE"
	CREDITCARDS_THEME = "#808000"
	DOCUMENTS_THEME = "#E0D91B"
	EMAIL_THEME = Application("ThemeColor")
	FACEBOOK_THEME = "#0A2252"
	HEALTH_THEME = "#A9BDD4"
	HOME_THEME = Application("ThemeColor")
	JOBS_THEME = "#DC9ACA"
	LOGOUT_THEME = "#000000"
	MUSIC_THEME = "GRAY"
	METROCARD_THEME = "#E9B41A"
	MOVIES_THEME = "#996600"
	MOVIE_COLLECTION_THEME = "#E0981B"
	NOTES_THEME = "yellow"
	PERSONAL_INFORMATION_THEME = "#469AC7"
	PHONEBILL_THEME = Application("ThemeColor")
	PHOTOS_THEME = "PINK"
	RECOVERY_THEME = "PURPLE"
	REMINDERS_THEME = "#9966FF"
	SETTINGS_THEME = "#666967"
	SERVER_THEME = "#FF0000"
	SNIPPETS_THEME = "#E0981B"
	TIMESHEET_THEME = "#469AC7"
	TIRADOONLINE_THEME = "BLUE"
	UPLOADS_THEME = "#666967"
%>

