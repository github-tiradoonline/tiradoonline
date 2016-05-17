<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "tiradoonlineTheme"
	PageThemeColor = TIRADOONLINE_THEME
	PageTitle = "tiradoonline"
	HeaderTitle = "tiradoonline"

	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->
<!-- #include virtual="/includes/functions.inc" -->
<%

	Alias = Trim(Request("Alias"))
	Browser = Trim(Request("Browser"))
	FilteredIPAddressID = Trim(Request("FilteredIPAddressID"))
	FilteredBrowserID = Trim(Request("FilteredBrowserID"))
	IPAddress = Trim(Request("IPAddress"))
	ResumeDownloadID = Trim(Request("ResumeDownloadID"))	

	ResumeDownloadTypeID = Trim(Request("ResumeDownloadTypeID"))	
	ResumeDownloadTypeName = Trim(Request("ResumeDownloadTypeName"))	
	ResumeDownloadTypeFileName = Trim(Request("ResumeDownloadTypeFileName"))	

	ReferencedByID = Trim(Request("ReferencedByID"))
	OrderNum = Trim(Request("OrderNum"))
	ReferencedByName = Trim(Request("ReferencedByName"))
	
	If SubmitButton = "DeleteSessionFilter" Then
		sql = "sp_Sessions_delete '" & SQLEncode(Browser) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		oConn.Close
		tiradoonlineErrorMessage = Server.URLEncode("Browser deleted '" & Browser & "' from Sessions and added to filters")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Save Filtered IPAddress" Then
		sql = "UPDATE FilteredIPAddresses SET " & _
		      "Alias = '" & SQLEncode(Alias) & "', " & _
			  "IPAddress = '" & SQLEncode(IPAddress) & "' " & _
			  "WHERE FilteredIPAddressID = " & _
			  FilteredIPAddressID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql

		tiradoonlineErrorMessage = Server.URLEncode("Filtered IPAddress saved.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Create Filtered IPAddress" Then
		sql = "INSERT INTO FilteredIPAddresses " & _
			  "(Alias, IPAddress) VALUES (" & _
		      "'" & SQLEncode(Alias) & "', " & _
			  "'" & SQLEncode(IPAddress) & "')"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		
		tiradoonlineErrorMessage = Server.URLEncode("Filtered IPAddress created.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteFilteredIPAddress" Then
		sql = "DELETE FROM FilteredIPAddresses WHERE FilteredIPAddressID = " & FilteredIPAddressID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Filtered IPAddress deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Save Filtered Browser" Then
		sql = "UPDATE FilteredBrowsers SET " & _
		      "Alias = '" & SQLEncode(Alias) & "', " & _
			  "Browser = '" & SQLEncode(Browser) & "' " & _
			  "WHERE FilteredBrowserID = " & _
			  FilteredBrowserID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		Response.Write sql & "<br>"
		
		sql = "sp_Sessions_FilteredBrowsers_delete"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		Response.Write sql & "<br>"

		'Response.End
		tiradoonlineErrorMessage = Server.URLEncode("Filtered Browser saved.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Create Filtered Browser" Then
		sql = "INSERT INTO FilteredBrowsers " & _
			  "(Alias, Browser) VALUES (" & _
		      "'" & SQLEncode(Alias) & "', " & _
			  "'" & SQLEncode(Browser) & "')"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		Response.Write sql & "<br>"
		
		sql = "sp_Sessions_FilteredBrowsers_delete"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql

		tiradoonlineErrorMessage = Server.URLEncode("Filtered Browser created.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteFilteredBrowser" Then
		sql = "DELETE FROM FilteredBrowsers WHERE FilteredBrowserID = " & FilteredBrowserID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Filtered Browser deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteFilteredIPAddress" Then
		sql = "DELETE FROM FilteredIPAddresses WHERE FilteredIPAddressID = " & FilteredIPAddressID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Filtered IPAddress deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Save Resume Type" Then
		sql = "UPDATE ResumeDownloadType SET " & _
		      "ResumeDownloadTypeName = '" & SQLEncode(ResumeDownloadTypeName) & "', " & _
			  "ResumeDownloadTypeFileName = '" & SQLEncode(ResumeDownloadTypeFileName) & "' " & _
			  "WHERE ResumeDownloadTypeID = " & _
			  ResumeDownloadTypeID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Resume Type saved.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Create Resume Type" Then
		sql = "INSERT INTO ResumeDownloadType " & _
			  "(UserID, ResumeDownloadTypeName, ResumeDownloadTypeFileName) VALUES (" & _
			  Session("UserID") & ", " & _
		      "'" & SQLEncode(ResumeDownloadTypeName) & "', " & _
			  "'" & SQLEncode(ResumeDownloadTypeFileName) & "')"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Resume Type created.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteResumeDownloadType" Then
		sql = "DELETE FROM ResumeDownloadType WHERE ResumeDownloadTypeID = " & ResumeDownloadTypeID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Filtered IPAddress deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteDownloadedResume" Then
		sql = "sp_ResumeDownloads_delete " & ResumeDownloadID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Downloaded Resume deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Save Referenced By" Then
		sql = "UPDATE ReferencedBy SET " & _
		      "OrderNum = " & OrderNum & ", " & _
			  "ReferencedByName = '" & SQLEncode(ReferencedByName) & "' " & _
			  "WHERE ReferencedByID = " & _
			  ReferencedByID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("OrderNum Type saved.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "Create Referenced By" Then
		sql = "INSERT INTO ReferencedBy " & _
			  "(UserID, OrderNum, ReferencedByName) VALUES (" & _
			  Session("UserID") & ", " & _
		      OrderNum & ", " & _
			  "'" & SQLEncode(ReferencedByName) & "')"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Referenced By created.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	ElseIf SubmitButton = "DeleteReferencedBy" Then
		sql = "DELETE FROM ReferencedBy WHERE ReferencedByID = " & ReferencedByID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		tiradoonlineErrorMessage = Server.URLEncode("Referenced By deleted.")
		Response.Redirect SCRIPT_NAME & "?Template="& Template & "&tiradoonlineErrorMessage=" & tiradoonlineErrorMessage
	End If
%>

<!-- #include virtual="/includes/open_header.inc" -->

&nbsp;<br />
<div style="float:right">
	<%= Button("Button", "tiradoonline.com Home", "Button", "", "tiradoonline.com", "location.href='" & SCRIPT_NAME & "'") %>
</div>
&nbsp;<br />
&nbsp;<br />
				<% If Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% ElseIf LCase(Template) = "browser_visits" Then %>
					<!-- #include file="templates/browser_visits.tem" -->
				<% ElseIf LCase(Template) = "filtered_ipaddresses" Then %>
					<!-- #include file="templates/filtered_ipaddresses.tem" -->
				<% ElseIf LCase(Template) = "filtered_browsers" Then %>
					<!-- #include file="templates/filtered_browsers.tem" -->
				<% ElseIf LCase(Template) = "downloaded_resumes" Then %>
					<!-- #include file="templates/downloaded_resumes.tem" -->
				<% ElseIf LCase(Template) = "resume_download_type" Then %>
					<!-- #include file="templates/resume_download_type.tem" -->
				<% ElseIf LCase(Template) = "referenced_by" Then %>
					<!-- #include file="templates/referenced_by.tem" -->
				<% End If %>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
