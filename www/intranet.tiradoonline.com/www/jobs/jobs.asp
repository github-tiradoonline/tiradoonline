<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "jobsTheme"
	PageThemeColor = JOBS_THEME
	PageTitle = "Jobs"
	HeaderTitle = "Jobs"
	Response.Buffer = true
	
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<!-- #include virtual = "/includes/upload.inc" -->
<%
	Set objFSO = CreateObject("Scripting.FileSystemObject")

	If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
	
		ks = Upload.UploadedFiles.keys
    	if (UBound(ks) <> -1) then
        	for each fileKey in Upload.UploadedFiles.keys
            	ResumeFileName = Upload.UploadedFiles(fileKey).FileName
	        next
    	end if

		If SubmitButton = "Upload Resume" Then
			JobsErrorMessage = Server.URLEncode("Resume '" & ResumeFileName & "' uploaded.")
			RedirectURL = SCRIPT_NAME & "?Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage
			Response.Redirect RedirectURL
		End If
	End If
	
	'***************** CREATE UPLOADS DIRECTORY ***************
	ResumeUploadsDirectory = Server.MapPath("/jobs/uploads/")
	FolderCreate ResumeUploadsDirectory
	WriteDebugger ResumeUploadsDirectory & " created.", Debugging, 0
	'*************************************************************

	'***************** CREATE UPLOADS DIRECTORY W/ BankingACCOUNTID ***************
	ResumeUploadsDirectory = ResumeUploadsDirectory & "\resumes"
	FolderCreate ResumeUploadsDirectory
	WriteDebugger ResumeUploadsDirectory & " created.", Debugging, 0
	'*************************************************************


	'***************** CREATE UPLOADS DIRECTORY W/ BankingACCOUNTID W/ USERID ***************
	ResumeUploadsDirectory = ResumeUploadsDirectory & "\" & Session("UserID")
	FolderCreate ResumeUploadsDirectory
	WriteDebugger ResumeUploadsDirectory & " created.", Debugging, 0
	'*************************************************************

	Session("ResumeUploadsDirectory") = ResumeUploadsDirectory

	JobID = Trim(Request("JobID"))
	JobQueueID = Trim(Request("JobQueueID"))

	'SEARCH
	JobCompanyNameSearch = Trim(Request("JobCompanyNameSearch"))
	JobCompanyContactSearch = Trim(Request("JobCompanyContactSearch"))
	JobCompanySearchID = Trim(Request("JobCompanySearchID"))
	JobQueueID = Trim(Request("JobQueueID"))
	
	JobCompanyID = Trim(Request("JobCompanyID"))
	JobCompanyName = Trim(Request("JobCompanyName"))
	'If JobCompanyID = "" Then JobCompanyName = ""
	JobClient = Trim(Request("JobClient"))
	JobPosition = Trim(Request("JobPosition"))
	JobCompanyPhone = Trim(Request("JobCompanyPhone"))
	JobCompanyPhone2 = Trim(Request("JobCompanyPhone2"))
	JobCompanyFax = Trim(Request("JobCompanyFax"))
	JobCompanyEmail = Trim(Request("JobCompanyEmail"))
	If JobCompanyEmail <> "" Then
		JobCompanyEmail = LCase(JobCompanyEmail)
	End If
	JobCompanyWebsite = Trim(Request("JobCompanyWebsite"))
	If JobCompanyWebsite <> "" Then JobCompanyWebsite = FormatWebsite(JobCompanyWebsite)
	JobCompanyLinkedIn = Trim(Request("JobCompanyLinkedIn"))
	If JobCompanyLinkedIn <> "" Then JobCompanyLinkedIn = FormatWebsite(JobCompanyLinkedIn)
	JobCompanyTwitter = Trim(Request("JobCompanyTwitter"))
	If JobCompanyTwitter <> "" Then JobCompanyTwitter = FormatWebsite(JobCompanyTwitter)
	JobCompanyFacebook = Trim(Request("JobCompanyFacebook"))
	If JobCompanyFacebook <> "" Then JobCompanyFacebook = FormatWebsite(JobCompanyFacebook)
	JobCompanyGooglePlus = Trim(Request("JobCompanyGooglePlus"))
	If JobCompanyGooglePlus <> "" Then JobCompanyGooglePlus = FormatWebsite(JobCompanyGooglePlus)
	JobCompanyYouTube = Trim(Request("JobCompanyYouTube"))
	If JobCompanyYouTube <> "" Then JobCompanyYouTube = FormatWebsite(JobCompanyYouTube)
	JobCompanyInstagram = Trim(Request("JobCompanyInstagram"))
	If JobCompanyInstagram <> "" Then JobCompanyInstagram = FormatWebsite(JobCompanyInstagram)
	JobCompanyPinterest = Trim(Request("JobCompanyPinterest"))
	If JobCompanyPinterest <> "" Then JobCompanyPinterest = FormatWebsite(JobCompanyPinterest)
	JobDate = Trim(Request("JobDate"))
	JobSalary = Trim(Request("JobSalary"))
	JobSalaryTypeID = Trim(Request("JobSalaryTypeID"))
	If JobSalary <> "" Then
		JobSalary = Replace(JobSalary, ",", "")
	End If
	If JobSalary = "" Then JobSalary = 0
	JobCity = Trim(Request("JobCity"))
	JobStateID = Trim(Request("JobStateID"))
	If JobStateID = "" Then JobStateID = Application("StateID")
	JobYearlyHourly = Trim(Request("JobYearlyHourly"))
	JobRequirements = Trim(Request("JobRequirements"))
	JobNotes = Trim(Request("JobNotes"))

	JobCompanyAddressID = Trim(Request("JobCompanyAddressID"))
	JobCompanyAddress1 = Trim(Request("JobCompanyAddress1"))
	JobCompanyAddress2 = Trim(Request("JobCompanyAddress2"))
	JobCompanyAddressCity = Trim(Request("JobCompanyAddressCity"))
	StateID = Trim(Request("StateID"))
	If StateID = "" Then StateID = Application("StateID")
	JobCompanyAddressZipCode = Trim(Request("JobCompanyAddressZipCode"))
	JobCompanyAddressPhone = Trim(Request("JobCompanyAddressPhone"))
	JobCompanyAddressPhone2 = Trim(Request("JobCompanyAddressPhone2"))
	JobCompanyAddressFax = Trim(Request("JobCompanyAddressFax"))
	JobCompanyAddressEmail = Trim(Request("JobCompanyAddressEmail"))

	JobCompanyContactID = Trim(Request("JobCompanyContactID"))
	JobCompanyContactTitle = Trim(Request("JobCompanyContactTitle"))
	JobCompanyContactFirstName = Trim(Request("JobCompanyContactFirstName"))
	JobCompanyContactLastName = Trim(Request("JobCompanyContactLastName"))
	JobCompanyContactWorkPhone = Trim(Request("JobCompanyContactWorkPhone"))
	JobCompanyContactWorkPhone2 = Trim(Request("JobCompanyContactWorkPhone2"))
	JobCompanyContactCellPhone = Trim(Request("JobCompanyContactCellPhone"))
	JobCompanyContactFax = Trim(Request("JobCompanyContactFax"))
	JobCompanyContactEmail = Trim(Request("JobCompanyContactEmail"))
	JobCompanyContactEmail2 = Trim(Request("JobCompanyContactEmail2"))
	JobCompanyContactLinkedIn = Trim(Request("JobCompanyContactLinkedIn"))
	JobCompanyContactTwitter = Trim(Request("JobCompanyContactTwitter"))
	JobCompanyContactFacebook = Trim(Request("JobCompanyContactFacebook"))
	JobCompanyContactGooglePlus = Trim(Request("JobCompanyContactGooglePlus"))
	JobCompanyContactInstagram = Trim(Request("JobCompanyContactInstagram"))
	JobCompanyContactSkype = Trim(Request("JobCompanyContactSkype"))
	JobCompanyContactHotmail = Trim(Request("JobCompanyContactHotmail"))
	JobCompanyContactYahoo = Trim(Request("JobCompanyContactYahoo"))
	JobCompanyContactAIM = Trim(Request("JobCompanyContactAIM"))
	JobCompanyContactGmail = Trim(Request("JobCompanyContactGmail"))
	If JobCompanyContactLinkedIn <> "" Then JobCompanyContactLinkedIn = FormatWebsite(JobCompanyContactLinkedIn)
	If JobCompanyContactTwitter <> "" Then JobCompanyContactTwitter = FormatWebsite(JobCompanyContactTwitter)
	If JobCompanyContactFacebook <> "" Then JobCompanyContactFacebook = FormatWebsite(JobCompanyContactFacebook)
	If JobCompanyContactGooglePlus <> "" Then JobCompanyContactGooglePlus = FormatWebsite(JobCompanyContactGooglePlus)
	If JobCompanyContactInstagram <> "" Then JobCompanyContactInstagram = FormatWebsite(JobCompanyContactInstagram)
	If JobCompanyContactPinterest <> "" Then JobCompanyContactPinterest = FormatWebsite(JobCompanyContactPinterest)
	JobCompanyContactNotes = Trim(Request("JobCompanyContactNotes"))
	Letter = Trim(Request("Letter"))

	JobCoverLetterID = Trim(Request("JobCoverLetterID"))
	JobCoverLetterName = Trim(Request("JobCoverLetterName"))
	JobCoverLetterText = Trim(Request("JobCoverLetterText"))
	
	JobCompanyPhoneCallID = Trim(Request("JobCompanyPhoneCallID"))
	JobCompanyPhoneCallTypeID = Trim(Request("JobCompanyPhoneCallTypeID"))
	JobCompanyPhoneCallDate = Trim(Request("JobCompanyPhoneCallDate"))
	If JobCompanyPhoneCallDate = "" Then JobCompanyPhoneCallDate = FormatDateTime(Now, 2)
	JobCompanyPhoneCallTime = Trim(Request("JobCompanyPhoneCallTime"))
	If JobCompanyPhoneCallTime = "" Then JobCompanyPhoneCallTime = FormatDateTime(Now, 3)
	JobCompanyPhoneCallDateTime = JobCompanyPhoneCallDate & " " & JobCompanyPhoneCallTime
	JobCompanyPhoneCallPhoneNumber = Trim(Request("JobCompanyPhoneCallPhoneNumber"))
	JobCompanyPhoneCallNotes = Trim(Request("JobCompanyPhoneCallNotes"))
	
	JobInterviewID = Trim(Request("JobInterviewID"))
	JobInterviewTypeID = Trim(Request("JobInterviewTypeID"))
	JobInterviewDate = Trim(Request("JobInterviewDate"))
	If JobInterviewDate = "" Then JobInterviewDate = FormatDateTime(Now, 2)
	JobInterviewTime = Trim(Request("JobInterviewTime"))
	If JobInterviewTime = "" Then JobInterviewTime = FormatDateTime(Now, 3)
	JobInterviewDateTime = JobInterviewDate & " " & JobInterviewTime
	JobInterviewClientID = Trim(Request("JobInterviewClientID"))
	'If JobInterviewClientID = "" Then JobInterviewClientID = JobCompanyID
	JobInterviewClientContactID = Trim(Request("JobInterviewClientContactID"))
	JobInterviewContact = Trim(Request("JobInterviewContact"))
	JobInterviewAddress1 = Trim(Request("JobInterviewAddress1"))
	JobInterviewAddress2 = Trim(Request("JobInterviewAddress2"))
	JobInterviewCity = Trim(Request("JobInterviewCity"))
	JobInterviewStateID = Trim(Request("JobInterviewStateID"))
	If JobInterviewStateID = "" Then JobInterviewStateID = Application("StateID")
	JobInterviewZipCode = Trim(Request("JobInterviewZipCode"))
	JobInterviewNotes = Trim(Request("JobInterviewNotes"))
	
	
	
	'***************************************************'
	'******************* SUBMIT RESUME *****************'
	'***************************************************'
	If SubmitButton = "Submit Resume(s)" Then
		JobQueueID = Trim(Request("JobQueueID"))
		jobqueueArray = Split(JobQueueID, ",")
		For x = 0 To UBound(jobqueueArray)
			Response.Write "<br>" & jobqueueArray(x)
		Next
		JobsErrorMessage = Server.URLEncode("Resume '" & ResumeFileName & "' deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage
	
	
	
	
	'***************************************************'
	'******************* DELETE RESUME *****************'
	'***************************************************'
	ElseIf SubmitButton = "DeleteResume" Then
		ResumeFileName = Trim(Request("ResumeFileName"))
		FileName = Session("ResumeUploadsDirectory") & "\" & ResumeFileName
		If objFSO.FileExists(FileName) then
  			objFSO.DeleteFile(FileName)
			JobsErrorMessage = Server.URLEncode("Resume '" & ResumeFileName & "' deleted.")
		Else
			JobsErrorMessage = Server.URLEncode("Resume '" & ResumeFileName & "' not found and could not be deleted.")
		End If
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage
	
	
	
	'***************************************************'
	'******************* COMPANIES *********************'
	'***************************************************'
	ElseIf SubmitButton = "Create Company" Then
		If JobCompanyWebsite <> "" Then JobCompanyWebsite = FormatWebsite(JobCompanyWebsite)
		If JobCompanyLinkedIn <> "" Then JobCompanyLinkedIn = FormatWebsite(JobCompanyLinkedIn)
		If JobCompanyTwitter <> "" Then JobCompanyTwitter = FormatWebsite(JobCompanyTwitter)
		If JobCompanyFacebook <> "" Then JobCompanyFacebook = FormatWebsite(JobCompanyFacebook)
		If JobCompanyGooglePlus <> "" Then JobCompanyGooglePlus = FormatWebsite(JobCompanyGooglePlus)
		If JobCompanyInstagram <> "" Then JobCompanyGooglePlus = FormatWebsite(JobCompanyInstagram)
		If JobCompanyPinterest <> "" Then JobCompanyGooglePlus = FormatWebsite(JobCompanyPinterest)
		If JobSalary = "" Then JobSalary = 0
		sql = "sp_JobCompany_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(JobCompanyName) & "', " & _
			  "'" & SQLEncode(JobCompanyPhone) & "', " & _
			  "'" & SQLEncode(JobCompanyPhone2) & "', " & _
			  "'" & SQLEncode(JobCompanyFax) & "', " & _
			  "'" & SQLEncode(JobCompanyEmail) & "', " & _
			  "'" & SQLEncode(JobCompanyWebsite) & "', " & _
			  "'" & SQLEncode(JobCompanyLinkedIn) & "', " & _
			  "'" & SQLEncode(JobCompanyTwitter) & "', " & _
			  "'" & SQLEncode(JobCompanyFacebook) & "', " & _
			  "'" & SQLEncode(JobCompanyGooglePlus) & "', " & _
			  "'" & SQLEncode(JobCompanyYouTube) & "', " & _
			  "'" & SQLEncode(JobCompanyInstagram) & "', " & _
			  "'" & SQLEncode(JobCompanyPinterest) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		JobCompanyID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Company '" & JobCompanyName & "' created.")
		Response.Redirect SCRIPT_NAME & "?Template=company_address&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Company" Then
		If JobCompanyWebsite <> "" Then JobCompanyWebsite = FormatWebsite(JobCompanyWebsite)
		sql = "UPDATE JobCompany SET " & _
		      "JobCompanyName = '" & SQLEncode(JobCompanyName) & "', " & _
		      "JobCompanyPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyPhone) & "'), " & _
		      "JobCompanyPhone2 = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyPhone2) & "'), " & _
		      "JobCompanyFax = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyFax) & "'), " & _
		      "JobCompanyEmail = '" & SQLEncode(JobCompanyEmail) & "', " & _
		      "JobCompanyWebsite = '" & SQLEncode(JobCompanyWebsite) & "', " & _
		      "JobCompanyLinkedIn = '" & SQLEncode(JobCompanyLinkedIn) & "', " & _
		      "JobCompanyTwitter = '" & SQLEncode(JobCompanyTwitter) & "', " & _
		      "JobCompanyFacebook = '" & SQLEncode(JobCompanyFacebook) & "', " & _
		      "JobCompanyGooglePlus = '" & SQLEncode(JobCompanyGooglePlus) & "', " & _
		      "JobCompanyYouTube = '" & SQLEncode(JobCompanyYouTube) & "', " & _
		      "JobCompanyInstagram = '" & SQLEncode(JobCompanyInstagram) & "', " & _
		      "JobCompanyPinterest = '" & SQLEncode(JobCompanyPinterest) & "' " & _
			  "WHERE JobCompanyID = " & JobCompanyID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		'Response.Write sql
		'Response.End
		JobsErrorMessage = Server.URLEncode("Company updated.")
		Response.Redirect SCRIPT_NAME & "?JobCompanyID=" & JobCompanyID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage



	'***************************************************'
	'******************* COMPANY ADDRESSES *************'
	'***************************************************'
	ElseIf SubmitButton = "Create Company Address" Then
		sql = "INSERT INTO JobCompanyAddress " & _
		      "(JobCompanyID, JobCompanyAddress1, JobCompanyAddress2, JobCompanyAddressCity, StateID, JobCompanyAddressZipCode, JobCompanyAddressPhone, JobCompanyAddressPhone2, JobCompanyAddressFax, JobCompanyAddressEmail) VALUES (" & _
			  JobCompanyID & ", " & _
			  "'" & SQLEncode(JobCompanyAddress1) & "', " & _
			  "'" & SQLEncode(JobCompanyAddress2) & "', " & _
			  "'" & SQLEncode(JobCompanyAddressCity) & "', " & _
			  StateID & ", " & _
			  "'" & SQLEncode(JobCompanyAddressZipCode) & "', " & _
			  "dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressPhone) & "'), " & _
			  "dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressPhone2) & "'), " & _
			  "dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressFax) & "'), " & _
			  "'" & SQLEncode(JobCompanyAddressEmail) & "'" & _
			  ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Company Address added.")
		Response.Redirect SCRIPT_NAME & "?Template=company_contact&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Company Address" Then
		sql = "UPDATE JobCompanyAddress SET " & _
		      "JobCompanyAddress1 = '" & SQLEncode(JobCompanyAddress1) & "', " & _
		      "JobCompanyAddress2 = '" & SQLEncode(JobCompanyAddress2) & "', " & _
		      "JobCompanyAddressCity = '" & SQLEncode(JobCompanyAddressCity) & "', " & _
		      "StateID = " & StateID & ", " & _
		      "JobCompanyAddressZipCode = '" & SQLEncode(JobCompanyAddressZipCode) & "', " & _
		      "JobCompanyAddressPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressPhone) & "'), " & _
		      "JobCompanyAddressPhone2 = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressPhone2) & "'), " & _
		      "JobCompanyAddressFax = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyAddressFax) & "'), " & _
		      "JobCompanyAddressEmail = '" & SQLEncode(JobCompanyAddressEmail) & "' " & _
			  "WHERE JobCompanyAddressID = " & JobCompanyAddressID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Company Address updated.")
		Response.Redirect SCRIPT_NAME & "?JobCompanyID="& JobCompanyID & "&JobCompanyAddressID=" & JobCompanyAddressID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "DeleteJobCompanyAddress" Then
		sql = "DELETE FROM JobCompanyAddress WHERE JobCompanyAddressID = " & JobCompanyAddressID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Company Address deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=company&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage



	'***************************************************'
	'******************* COMPANY CONTACTS **************'
	'***************************************************'
	ElseIf SubmitButton = "Create Company Contact" Then
		sql = "sp_JobCompanyContact_insert " & _
			  JobCompanyID & ", " & _
			  "'" & SQLEncode(JobCompanyContactTitle) & "', " & _
			  "'" & SQLEncode(JobCompanyContactFirstName) & "', " & _
			  "'" & SQLEncode(JobCompanyContactLastName) & "', " & _
			  "'" & SQLEncode(JobCompanyContactWorkPhone) & "', " & _
			  "'" & SQLEncode(JobCompanyContactWorkPhone2) & "', " & _
			  "'" & SQLEncode(JobCompanyContactCellPhone) & "', " & _
			  "'" & SQLEncode(JobCompanyContactFax) & "', " & _
			  "'" & SQLEncode(JobCompanyContactEmail) & "', " & _
			  "'" & SQLEncode(JobCompanyContactEmail2) & "', " & _
			  "'" & SQLEncode(JobCompanyContactLinkedIn) & "', " & _ 
			  "'" & SQLEncode(JobCompanyContactTwitter) & "', " & _
			  "'" & SQLEncode(JobCompanyContactFacebook) & "', " & _
			  "'" & SQLEncode(JobCompanyContactGooglePlus) & "', " & _
			  "'" & SQLEncode(JobCompanyContactInstagram) & "', " & _
			  "'" & SQLEncode(JobCompanyContactSkype) & "', " & _
			  "'" & SQLEncode(JobCompanyContactHotmail) & "', " & _
			  "'" & SQLEncode(JobCompanyContactYahoo) & "', " & _
			  "'" & SQLEncode(JobCompanyContactAIM) & "', " & _
			  "'" & SQLEncode(JobCompanyContactGmail) & "', " & _
			  "'" & SQLEncode(JobCompanyContactNotes) & "'"

			  
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		JobCompanyContactID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Company Contact added.")
		Response.Redirect SCRIPT_NAME & "?Template=jobs&JobCompanyContactID=" & JobCompanyContactID & "&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Company Contact" Then
		sql = "UPDATE JobCompanyContact SET " & _
		      "JobCompanyContactTitle = '" & SQLEncode(JobCompanyContactTitle) & "', " & _
		      "JobCompanyContactFirstName = '" & SQLEncode(JobCompanyContactFirstName) & "', " & _
		      "JobCompanyContactLastName = '" & SQLEncode(JobCompanyContactLastName) & "', " & _
		      "JobCompanyContactWorkPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyContactWorkPhone) & "'), " & _
		      "JobCompanyContactWorkPhone2 = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyContactWorkPhone2) & "'), " & _
		      "JobCompanyContactCellPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyContactCellPhone) & "'), " & _
		      "JobCompanyContactFax = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyContactFax) & "'), " & _
		      "JobCompanyContactEmail = '" & SQLEncode(JobCompanyContactEmail) & "', " & _
		      "JobCompanyContactEmail2 = '" & SQLEncode(JobCompanyContactEmail2) & "', " & _
			  "JobCompanyContactLinkedIn = '" & SQLEncode(JobCompanyContactLinkedIn) & "', " & _
			  "JobCompanyContactTwitter = '" & SQLEncode(JobCompanyContactTwitter) & "', " & _
			  "JobCompanyContactFacebook = '" & SQLEncode(JobCompanyContactFacebook) & "', " & _
			  "JobCompanyContactGooglePlus = '" & SQLEncode(JobCompanyContactGooglePlus) & "', " & _
			  "JobCompanyContactInstagram = '" & SQLEncode(JobCompanyContactInstagram) & "', " & _
			  "JobCompanyContactSkype = '" & SQLEncode(JobCompanyContactSkype) & "', " & _
			  "JobCompanyContactHotmail = '" & SQLEncode(JobCompanyContactHotmail) & "', " & _
			  "JobCompanyContactYahoo = '" & SQLEncode(JobCompanyContactYahoo) & "', " & _
			  "JobCompanyContactAIM = '" & SQLEncode(JobCompanyContactAIM) & "', " & _
			  "JobCompanyContactGmail = '" & SQLEncode(JobCompanyContactGmail) & "', " & _
			  "JobCompanyContactNotes = '" & SQLEncode(JobCompanyContactNotes) & "' " & _
			  "WHERE JobCompanyContactID = " & JobCompanyContactID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Company Contact updated.")
		Response.Redirect SCRIPT_NAME & "?JobCompanyID="& JobCompanyID & "&JobCompanyContactID=" & JobCompanyContactID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage





	'***************************************************'
	'******************* JOBS **************************'
	'***************************************************'
	ElseIf SubmitButton = "Create Job" Then
		If JobSalary = "" Then JobSalary = 0
		sql = "sp_Jobs_insert " & _
			  JobCompanyID & ", " & _
			  JobCompanyContactID & ", " & _
			  JobSalaryTypeID & ", " & _
			  "'" & SQLEncode(JobDate) & "', " & _
			  "'" & SQLEncode(JobPosition) & "', " & _
			  JobSalary & ", " & _
			  "'" & SQLEncode(JobClient) & "', " & _
			  "'" & SQLEncode(JobCity) & "', " & _
			  JobStateID & ", " & _
			  "'" & SQLEncode(JobRequirements) & "', " & _
			  "'" & SQLEncode(JobNotes) & "'"
		WriteDebugger sql, Debugging, 0

		
		Set ors = oConn.Execute(sql)
		JobID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Job created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Job" Then
		sql = "UPDATE Jobs SET " & _
			  "JobCompanyContactID = " & JobCompanyContactID & ", " & _
			  "JobSalaryTypeID = " & JobSalaryTypeID & ", " & _
			  "JobDate = '" & SQLEncode(JobDate) & "', " & _
			  "JobPosition = '" & SQLEncode(JobPosition) & "', " & _
			  "JobSalary = " & JobSalary & ", " & _
			  "JobClient = '" & SQLEncode(JobClient) & "', " & _
			  "JobCity = '" & SQLEncode(JobCity) & "', " & _
			  "JobStateID = " & JobStateID & ", " & _
			  "JobRequirements = '" & SQLEncode(JobRequirements) & "', " & _
			  "JobNotes = '" & SQLEncode(JobNotes) & "' " & _
			  "WHERE JobID = " & JobID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Job saved.")
		Response.Redirect SCRIPT_NAME & "?JobID=" & JobID & "&JobCompanyID="& JobCompanyID & "&JobCompanyContactID=" & JobCompanyContactID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage





	ElseIf SubmitButton = "Add to Job Queue" Then
		sql = "sp_JobQueue_insert " & JobID
		Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Job inserted in to Queue.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCompanyID=" & JobCompanyID & "&JobID=" & JobID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Remove from Job Queue" Then
		sql = "sp_JobQueue_delete " & JobQueID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Job removed from Queue.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCompanyID=" & JobCompanyID & "&JobID=" & JobID & "&JobsErrorMessage=" & JobsErrorMessage

		
		
		
	'***************************************************'
	'******************* COVER LETTERS *****************'
	'***************************************************'
	ElseIf SubmitButton = "Create Cover Letter" Then
		sql = "sp_JobCoverLetter_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(JobCoverLetterName) & "', " & _
			  "'" & SQLEncode(JobCoverLetterText) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		JobCoverLetterID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Cover Letter '" & JobCoverLetterName & "' created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCoverLetterID=" & JobCoverLetterID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Cover Letter" Then
		If JobCoverLetterText <> "" Then FormatWebsite(JobCoverLetterText)
		sql = "UPDATE JobCoverLetter SET " & _
		      "JobCoverLetterName = '" & SQLEncode(JobCoverLetterName) & "', " & _
		      "JobCoverLetterText = '" & SQLEncode(JobCoverLetterText) & "' " & _
			  "WHERE JobCoverLetterID = " & JobCoverLetterID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Cover Letter updated.")
		Response.Redirect SCRIPT_NAME & "?JobCoverLetterID=" & JobCoverLetterID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage





	'***************************************************'
	'******************* INTERVIEWS ********************'
	'***************************************************'
	ElseIf SubmitButton = "Create Job Interview" Then
		sql = "sp_JobInterview_insert " & _
			  JobCompanyID & ", " & _
			  JobInterviewTypeID & ", " & _
			  "'" & SQLEncode(JobInterviewDateTime) & "', " & _
			  JobInterviewClientID & ", " & _
			  JobInterviewClientContactID & ", " & _
			  "'" & SQLEncode(JobInterviewAddress1) & "', " & _
			  "'" & SQLEncode(JobInterviewAddress2) & "', " & _
			  "'" & SQLEncode(JobInterviewCity) & "', " & _
			  JobInterviewStateID & ", " & _
			  "'" & SQLEncode(JobInterviewZipCode) & "', " & _
			  "'" & SQLEncode(JobInterviewNotes) & "'"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		JobInterviewID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Job Interview created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCompanyID=" & JobCompanyID & "&JobInterviewID=" & JobInterviewID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Job Interview" Then
		sql = "UPDATE JobInterview SET " & _
			  "JobInterviewTypeID = " & JobInterviewTypeID & ", " & _
			  "JobInterviewDateTime = '" & SQLEncode(JobInterviewDateTime) & "', " & _
			  "JobInterviewClientID = " & JobInterviewClientID & ", " & _
			  "JobInterviewClientContactID = '" & SQLEncode(JobInterviewClientContactID) & "', " & _
			  "JobInterviewAddress1 = '" & SQLEncode(JobInterviewAddress1) & "', " & _
			  "JobInterviewAddress2 = '" & SQLEncode(JobInterviewAddress2) & "', " & _
			  "JobInterviewCity = '" & SQLEncode(JobInterviewCity) & "', " & _
			  "StateID = " & JobInterviewStateID & ", " & _
			  "JobInterviewZipCode = '" & SQLEncode(JobInterviewZipCode) & "', " & _
			  "JobInterviewNotes = '" & SQLEncode(JobInterviewNotes) & "' " & _
			  "WHERE JobInterviewID = " & JobInterviewID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Job Interview saved.")
		Response.Redirect SCRIPT_NAME & "?JobInterviewID=" & JobInterviewID & "&JobCompanyID="& JobCompanyID & "&JobCompanyContactID=" & JobCompanyContactID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage





	'***************************************************'
	'******************* PHONE CALLS  ******************'
	'***************************************************'
	ElseIf SubmitButton = "Create Phone Call" Then
		sql = "sp_JobCompanyPhoneCall_insert " & _
			  JobCompanyID & ", " & _
			  JobCompanyContactID & ", " & _
			  JobCompanyPhoneCallTypeID & ", " & _
			  "'" & SQLEncode(JobCompanyPhoneCallDateTime) & "', " & _
			  "'" & SQLEncode(JobCompanyPhoneCallPhoneNumber) & "', " & _
			  "'" & SQLEncode(JobCompanyPhoneCallNotes) & "'"
		
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		JobCompanyPhoneCallID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		JobsErrorMessage = Server.URLEncode("Phone Call created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&JobCompanyID=" & JobCompanyID & "&JobsErrorMessage=" & JobsErrorMessage
	ElseIf SubmitButton = "Save Phone Call" Then
		sql = "UPDATE JobCompanyPhoneCall SET " & _
			  "JobCompanyContactID = '" & SQLEncode(JobCompanyContactID) & "', " & _
			  "JobCompanyPhoneCallTypeID = " & JobCompanyPhoneCallTypeID & ", " & _
			  "JobCompanyPhoneCallDateTime = '" & SQLEncode(JobCompanyPhoneCallDateTime) & "', " & _
			  "JobCompanyPhoneCallPhoneNumber = dbo.fn_FormatPhoneNumber('" & SQLEncode(JobCompanyPhoneCallPhoneNumber) & "'), " & _
			  "JobCompanyPhoneCallNotes = '" & SQLEncode(JobCompanyPhoneCallNotes) & "' " & _
			  "WHERE JobCompanyPhoneCallID = " & JobCompanyPhoneCallID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		JobsErrorMessage = Server.URLEncode("Phone Call saved.")
		Response.Redirect SCRIPT_NAME & "?JobCompanyPhoneCallID=" & JobCompanyPhoneCallID & "&JobCompanyID="& JobCompanyID & "&JobCompanyContactID=" & JobCompanyContactID & "&Template=" & Template & "&JobsErrorMessage=" & JobsErrorMessage








	Else
		SelectedTab = 0
	
		UserName = ""
		Password = ""
	End If 
%>

<!-- #include virtual="/includes/open_header.inc" -->
&nbsp;<br>
<form action="<%= SCRIPT_NAME %>?Template=companies" method="post">

<table width="100%">
<tr>
	<td valign="middle" align="center">
		<%= Button("Button", "Dashboard", "Button", "", "Dashboard", "location.href='" & SCRIPT_NAME & "?Template=companies'") %>
	</td>
	<td align="right">
	<table>
	<tr valign="top" align="right">
		<td>
			<%= formTextBox("JobCompanyNameSearch", "30", JobCompanyNameSearch, "JobsElement", "JobCompanyNameSearch", "Invalid Company (Please enter at least 5 characters).") %><br>
			<% sql = "sp_JobCompany_UserID_get " & Session("UserID") %>
			<%= SelectBox(oConn, sql, "JobCompanySearchID", JobCompanySearchID, "JobsElement", "Company") %>
			<script type="text/javascript">
				
				$("#JobCompanySearchID").prepend("<option value='' selected='selected' style='text-align: center'><%= Server.HTMLEncode("<  ") %>Select Company<%= Server.HTMLEncode("  >") %></option>");

			</script>
		</td>
		<td>
			<%= Submit_Button("buttonCompanySearch", "Search Companies", "Button", "", "Search Companies") %>
		</td>
	</tr>
	<tr height="1" bgcolor="#000">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">
			<%= formTextBox("JobCompanyContactSearch", "30", JobCompanyContactSearch, "JobsElement", "JobCompanContactSearch", "Invalid Contact (Please enter at least 5 characters).") %>
		</td>
		<td>
			<%= Submit_Button("buttonContactSearch", "Search Contacts", "Button", "", "Search Contacts") %>
		</td>
	</tr>
	<tr height="1" bgcolor="#000">
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">
			<%= formTextBox("JobCompanyContactSearch", "30", JobCompanyContactSearch, "JobsElement", "JobCompanContactSearch", "Invalid Zip Code") %>
		</td>
		<td>
			<%= Submit_Button("buttonContactSearch", "Search by Zip Code", "Button", "", "Search by Zip Code") %>
		</td>
	</tr>
	</table>
	</td>
</tr>
</table>

<p />

</form>

<% If Template = "" OR Template = "companies" Then %>
	<!-- #include file="templates/companies.tem" -->
<% ElseIf Template = "company" Then %>
	<!-- #include file="templates/company.tem" -->
<% ElseIf Template = "resume" Then %>
	<!-- #include file="templates/resume.tem" -->
<% ElseIf Template = "job_resume_submit" Then %>
	<!-- #include file="templates/job_resume_submit.tem" -->
<% ElseIf Template = "jobs" Then %>
	<!-- #include file="templates/jobs.tem" -->
<% ElseIf Template = "company_address" Then %>
	<!-- #include file="templates/company_address.tem" -->
<% ElseIf Template = "company_contact" Then %>
	<!-- #include file="templates/company_contact.tem" -->
<% ElseIf Template = "cover_letter" Then %>
	<!-- #include file="templates/cover_letter.tem" -->
<% ElseIf Template = "job_interview" Then %>
	<!-- #include file="templates/job_interview.tem" -->
<% ElseIf Template = "job_phonecall" Then %>
	<!-- #include file="templates/job_phonecall.tem" -->
<% End If %>

<%= formHidden("JobCompanyContactID", JobCompanyContactID) %>

<%
	Set objFSO = Nothing
%>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
