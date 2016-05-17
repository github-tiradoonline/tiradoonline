<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	DocumentsDirectory = SettingsDirectory("DocumentsDirectory")
	If isNull(DocumentsDirectory) Then DocumentsDirectory = ""
	DirectoryExists = true
	Set objFileSystem = CreateObject("Scripting.FileSystemObject")
   	If NOT objFileSystem.FolderExists(DocumentsDirectory) Then 
		DocumentsErrorMessage = DocumentsErrorMessage & "Documents Directory does not exist."
		DirectoryExists = false
	End If
	Set objFileSystem = Nothing
	
	If NOT DirectoryExists Then Response.Redirect "/settings/settings.asp?Template=settings&DocumentsErrorMessage=" & Server.URLEncode(DocumentsErrorMessage)
	
	PageTheme = "documentsTheme"
	PageThemeColor = DOCUMENTS_THEME
	PageTitle = "Documents"
	HeaderTitle = "Documents"
	Response.Buffer = true
%>
<!-- #include virtual = "/includes/upload.inc" -->

<%
    Set Upload = New FreeASPUpload
	'Response.Write "Session(""DocumentsDirectory""):&nbsp;" & Session("DocumentsDirectory")
   	Upload.Save(Session("DocumentsDirectory"))
	Set Upload = Nothing

	If InStr(Request.ServerVariables("HTTP_CONTENT_TYPE"), "multipart/form-data") > 0 Then
		DocumentsErrorMessage = Server.URLEncode("File Uploaded created.")
		Response.Redirect SCRIPT_NAME & "?DocumentsErrorMessage=" & DocumentsErrorMessage & "&CurrentDirectory="&  Server.URLEncode(Session("DocumentsDirectory"))
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
			CurrentDirectory = ors("DocumentsDirectory")
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
		If CurrentDirectory = "" Then CurrentDirectory = Documents_Directory
		Session("DocumentsDirectory") = CurrentDirectory
		Response.Redirect SCRIPT_NAME & "?CurrentDirectory="&  Server.URLEncode(CurrentDirectory)
	ElseIf SubmitButton = "CreateFolder" Then
		FolderCreate CurrentDirectory
		DocumentsErrorMessage = Server.URLEncode("Folder created.")
		Response.Redirect SCRIPT_NAME & "?DocumentsErrorMessage=" & DocumentsErrorMessage & "&CurrentDirectory="&  Server.URLEncode(CurrentDirectory)
	ElseIf SubmitButton = "Upload File" Then
		Response.Write "<b>" & CurrentDirectory & "\" & FileName & "&nbsp;uploaded.</b><p>"
	End If

%>

<!-- #include virtual="/includes/open_header.inc" -->
<%
	If Session("DocumentsDirectory") = "" Then Session("DocumentsDirectory") = Documents_Directory
%>
<form method = "post" action = "<%= SCRIPT_NAME %>" enctype="multipart/form-data">

				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% End If %>

<%= formHidden("PostCurrentDirectory", CurrentDirectory) %>


</form>
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
