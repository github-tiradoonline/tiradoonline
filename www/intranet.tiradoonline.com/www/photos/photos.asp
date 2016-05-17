<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	PhotosDirectory = SettingsDirectory("PhotosDirectory")
	If isNull(PhotosDirectory) Then PhotosDirectory = ""
	DirectoryExists = true
	Set objFileSystem = CreateObject("Scripting.FileSystemObject")
   	If NOT objFileSystem.FolderExists(PhotosDirectory) Then 
		PhotosRecoveryErrorMessage = PhotosRecoveryErrorMessage & "Photos Directory does not exist."
		DirectoryExists = false
	End If
	Set objFileSystem = Nothing
	
	If NOT DirectoryExists Then Response.Redirect "/settings/settings.asp?Template=settings&PhotosRecoveryErrorMessage=" & Server.URLEncode(PhotosRecoveryErrorMessage)

	PageTheme = "photosTheme"
	PageThemeColor = PHOTOS_THEME
	PageTitle = "Photos"
	HeaderTitle = "Photos"
	Response.Buffer = true

%>
<!-- #include virtual = "/includes/upload.inc" -->

<%
    Set Upload = New FreeASPUpload
	'Response.Write "Session(""PhotosDirectory""):&nbsp;" & Session("PhotosDirectory")
   	Upload.Save(Session("PhotosDocumentsDirectory"))
	Set Upload = Nothing

	If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
		PhotosRecoveryErrorMessage = Server.URLEncode("Photo Uploaded created.")
		Response.Redirect SCRIPT_NAME & "?PhotosRecoveryErrorMessage=" & PhotosRecoveryErrorMessage & "&CurrentDirectory="&  Server.URLEncode(Session("PhotosDocumentsDirectory"))
	End If
%>
<%
	If Request.ServerVariables("REQUEST_METHOD") = "POST" Then 
		CurrentDirectory = Trim(Request("PostCurrentDirectory"))
	Else
		CurrentDirectory = Trim(Request("CurrentDirectory"))
	End If
	If CurrentDirectory = "" Then 
		sql = "sp_Settings_get " & Session("UserID")
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			CurrentDirectory = ors("PhotosDirectory")
			ors.Close
		End If
		Set ors = Nothing
	End If
	
	If SubmitButton = "ChangeDirectory" Then
		If Request.ServerVariables("REQUEST_METHOD") = "POST" Then 
			CurrentDirectory = Trim(Request("PostCurrentDirectory"))
		Else
			CurrentDirectory = Trim(Request("CurrentDirectory"))
		End If
		If CurrentDirectory = "" Then CurrentDirectory = Application("PhotosDocumentsDirectory")
		Session("PhotosDocumentsDirectory") = CurrentDirectory
		Response.Redirect SCRIPT_NAME & "?CurrentDirectory="&  Server.URLEncode(CurrentDirectory)
	ElseIf SubmitButton = "CreateFolder" Then
		FolderCreate CurrentDirectory
		PhotosRecoveryErrorMessage = Server.URLEncode("Folder created.")
		Response.Redirect SCRIPT_NAME & "?PhotosRecoveryErrorMessage=" & PhotosRecoveryErrorMessage & "&CurrentDirectory="&  Server.URLEncode(CurrentDirectory)
	ElseIf SubmitButton = "Upload File" Then
		'Response.Write "<b>" & CurrentDirectory & "\" & FileName & "&nbsp;uploaded.</b><p>"
	End If

%>
<!-- #include virtual="/includes/open_header.inc" -->
<%
	If Session("PhotosDirectory") = "" Then Session("PhotosDirectory") = Photos_Directory
%>

				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% End If %>

<%= formHidden("PostCurrentDirectory", CurrentDirectory) %>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
