<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "CollectionAgencyTheme"
	PageThemeColor = COLLECTION_AGENCY_THEME
	PageTitle = "Collection"
	HeaderTitle = "Collection"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	OrderBy = Trim(Request("OrderBy"))
	If OrderBy = "" Then OrderBy = "CollectionAgencyName"
	
	CollectionAgencyID = Trim(Request("CollectionAgencyID"))
	CollectionAgencyName = Trim(Request("CollectionAgencyName"))
	CollectionAgencyAddress1 = Trim(Request("CollectionAgencyAddress1"))
	CollectionAgencyAddress2 = Trim(Request("CollectionAgencyAddress2"))
	CollectionAgencyCity = Trim(Request("CollectionAgencyCity"))
	StateID = Trim(Request("StateID"))
	If StateID = "" Then StateID = Application("StateID")
	CollectionAgencyZipCode = Trim(Request("CollectionAgencyZipCode"))
	CollectionAgencyPhone = Trim(Request("CollectionAgencyPhone"))
	CollectionAgencyFax = Trim(Request("CollectionAgencyFax"))
	CollectionAgencyWebsite = Trim(Request("CollectionAgencyWebsite"))
	If CollectionAgencyWebsite <> "" Then CollectionAgencyWebsite = FormatWebsite(CollectionAgencyWebsite)
	CollectionAgencyEmail = Trim(Request("CollectionAgencyEmail"))
	CollectionAgencyNotes = Trim(Request("CollectionAgencyNotes"))

	CollectionID = Trim(Request("CollectionID"))
	CollectionCreditor = Trim(Request("CollectionCreditor"))
	CollectionStatementDate = Trim(Request("CollectionStatementDate"))
	CollectionNumber = Trim(Request("CollectionNumber"))
	CollectionRepresentative = Trim(Request("CollectionRepresentative"))
	CollectionAmount = Trim(Request("CollectionAmount"))
	If CollectionAmount = "" Then CollectionAmount = 0
	CollectionNotes = Trim(Request("CollectionNotes"))

	If SubmitButton = "DeleteCollectionAgency" Then
		sql = "DELETE FROM CollectionAgency WHERE CollectionAgencyID = " & CollectionAgencyID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection Agency deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CollectionErrorMessage=" & CollectionErrorMessage
	ElseIf SubmitButton = "Create Collection Agency" Then
		sql = "INSERT INTO CollectionAgency (UserID, CollectionAgencyName, CollectionAgencyAddress1, CollectionAgencyAddress2, CollectionAgencyCity, StateID, CollectionAgencyZipCode, CollectionAgencyPhone, CollectionAgencyFax, CollectionAgencyWebsite, CollectionAgencyEmail, CollectionAgencyNotes) VALUES (" & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(CollectionAgencyName) & "', " & _
			  "'" & SQLEncode(CollectionAgencyAddress1) & "', " & _
			  "'" & SQLEncode(CollectionAgencyAddress2) & "', " & _
			  "'" & SQLEncode(CollectionAgencyCity) & "', " & _
			  StateID & ", " & _
			  "'" & SQLEncode(CollectionAgencyZipCode) & "', " & _
			  "dbo.fn_FormatPhoneNumber('" & SQLEncode(CollectionAgencyPhone) & "'), " & _
			  "dbo.fn_FormatPhoneNumber('" & SQLEncode(CollectionAgencyFax) & "'), " & _
			  "'" & SQLEncode(CollectionAgencyWebsite) & "', " & _
			  "'" & SQLEncode(CollectionAgencyEmail) & "', " & _
			  "'" & SQLEncode(CollectionAgencyNotes) & "')"
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection Agency '" & CollectionAgencyName & "' added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CollectionErrorMessage=" & CollectionErrorMessage
	ElseIf SubmitButton = "Save Collection Agency" Then
		sql = "UPDATE CollectionAgency SET " & _
			  "CollectionAgencyName = '" & SQLEncode(CollectionAgencyName) & "', " & _
			  "CollectionAgencyAddress1 = '" & SQLEncode(CollectionAgencyAddress1) & "', " & _
			  "CollectionAgencyAddress2 = '" & SQLEncode(CollectionAgencyAddress2) & "', " & _
			  "CollectionAgencyCity = '" & SQLEncode(CollectionAgencyCity) & "', " & _
			  "StateID = " & StateID & ", " & _
			  "CollectionAgencyZipCode = '" & SQLEncode(CollectionAgencyZipCode) & "', " & _
			  "CollectionAgencyPhone = dbo.fn_FormatPhoneNumber('" & SQLEncode(CollectionAgencyPhone) & "'), " & _
			  "CollectionAgencyFax = dbo.fn_FormatPhoneNumber('" & SQLEncode(CollectionAgencyFax) & "'), " & _
			  "CollectionAgencyEmail = '" & SQLEncode(CollectionAgencyEmail) & "', " & _
			  "CollectionAgencyWebsite = '" & SQLEncode(CollectionAgencyWebsite) & "', " & _
			  "CollectionAgencyNotes = '" & SQLEncode(CollectionAgencyNotes) & "' " & _
			  "WHERE CollectionAgencyID = " & CollectionAgencyID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection Agency '" & CollectionAgencyName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CollectionErrorMessage=" & CollectionErrorMessage
	ElseIf SubmitButton = "Create Collection" Then
		sql = "INSERT INTO Collection (CollectionAgencyID, CollectionCreditor, CollectionStatementDate, CollectionNumber, CollectionRepresentative, CollectionAmount, CollectionNotes) VALUES (" & _
			  CollectionAgencyID & ", " & _
			  "'" & SQLEncode(CollectionCreditor) & "', " & _
			  "'" & SQLEncode(CollectionStatementDate ) & "', " & _
			  "'" & SQLEncode(CollectionNumber) & "', " & _
			  "'" & SQLEncode(CollectionRepresentative) & "', " & _
			  CollectionAmount & ", " & _
			  "'" & SQLEncode(CollectionNotes) & "')"
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=Collection&CollectionAgencyID=" & CollectionAgencyID & "&CollectionErrorMessage=" & CollectionErrorMessage
	ElseIf SubmitButton = "Save Collection" Then
		sql = "UPDATE Collection SET " & _
			  "CollectionCreditor = '" & SQLEncode(CollectionCreditor) & "', " & _
			  "CollectionStatementDate = '" & SQLEncode(CollectionStatementDate) & "', " & _
			  "CollectionNumber = '" & SQLEncode(CollectionNumber) & "', " & _
			  "CollectionRepresentative = '" & SQLEncode(CollectionRepresentative) & "', " & _
			  "CollectionAmount = " & CollectionAmount & ", " & _
			  "CollectionNotes = '" & SQLEncode(CollectionNotes) & "' " & _
			  "WHERE CollectionID = " & CollectionID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=Collection&CollectionAgencyID=" & CollectionAgencyID & "&CollectionErrorMessage=" & CollectionErrorMessage
	ElseIf SubmitButton = "DeleteCollection" Then
		sql = "DELETE FROM Collection WHERE CollectionID = " & CollectionID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CollectionErrorMessage = Server.URLEncode("Collection deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=Collection&CollectionAgencyID=" & CollectionAgencyID & "&CollectionErrorMessage=" & CollectionErrorMessage
	End If	
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<form action="<%= SCRIPT_NAME %>" method="post">
				<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
				<tr>
					<td class="frm_label"><b>&nbsp;&nbsp;&nbsp;Collection&nbsp;Agency&nbsp;Name:</b></font>&nbsp;</td>
					<td>
						<%= formTextBox("CollectionAgency_Name", "40", "", "CollectionAgencyElement", "Collection Agency Name", "Invalid Collection Agency Name") %>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff">
						<tr valign=top>
							<td>
								<%= Button("Button", "Create Collection Agency", "Button", "", "Create Collection Agency", "formCollectionAgencyCreate()") %>
							</td>
							<td>
								<%= Button("Button", "View All Collection Agencies", "Button", "", "", "location.href='" & SCRIPT_NAME & "?Template=Collection'") %>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				
				<%= formHidden("Template", Template) %>
				
				</form>
				&nbsp;<br />
				<% If CollectionErrorMessage <> "" Then %>
				<div class="ErrorMessage"><%= CollectionErrorMessage %></div>
				&nbsp;<br />
				<% End If %>
				<% If Template = "" Then %>
					<% CollectionImageID = "home" %>
					<!-- #include file="templates/home.tem" -->
				<% ElseIf Template = "Collection" Then %>
					<!-- #include file="templates/collection_agency.tem" -->
				<% End If %>
				


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->