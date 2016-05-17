<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "EmailTheme"
	PageThemeColor = Email_THEME
	PageTitle = "Email"
	HeaderTitle = "Email"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	POP3EmailAccountID = Trim(Request("POP3EmailAccountID"))
	POP3EmailAccountName = Trim(Request("POP3EmailAccountName"))
	POP3EmailFolderID = Trim(Request("POP3EmailFolderID"))
	POP3EmailFolderName = Trim(Request("POP3EmailFolderName"))
	POP3EmailID = Trim(Request("POP3EmailID"))
	
	If SubmitButton = "DeleteEmail" Then
		sql = "UPDATE POP3Email SET Active = 0 WHERE POP3EmailAccountID IN ( " & POP3EmailAccountID & ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		EmailErrorMessage = Server.URLEncode("Emails deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&EmailErrorMessage=" & EmailErrorMessage
	ElseIf SubmitButton = "Create Email Account" Then
		sql = "sp_POP3EmailAccount_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(POP3EmailAccountName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		EmailErrorMessage = Server.URLEncode("Email Account '" & POP3EmailAccountName & "' created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&EmailErrorMessage=" & EmailErrorMessage
	ElseIf SubmitButton = "Create Folder" Then
		sql = "sp_POP3EmailFolder_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(POP3EmailFolderName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		EmailErrorMessage = Server.URLEncode("Email Folder '" & POP3EmailFolderName & "' created.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&EmailErrorMessage=" & EmailErrorMessage
	End If	
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<table>
				<tr>
					<td style="font-size: 15px"><b>Email&nbsp;Account</b></td>
					<% If POP3EmailAccountID <> "" Then %>
					<td style="font-size: 15px" colspan="2"><b>Folder</b></td>
					<td style="font-size: 15px" colspan="2"><b>Company</b></td>
					<% End If %>
				</tr>
				<tr valign="top">
					<td>
						<%= SelectBox(oConn, "sp_POP3EmailAccount_UserID_get " & Session("UserID"), "POP3EmailAccountID", POP3EmailAccountID, "EmailElement", "Email Account") %>&nbsp;&nbsp;
					</td>
					<% If POP3EmailAccountID <> "" Then %>
					<td>
						<%= SelectBox(oConn, "sp_POP3EmailFolder_POP3EmailAccountID_get " & POP3EmailAccountID, "POP3EmailFolderID", POP3EmailFolderID, "EmailElement", "Email Folder") %>
					</td>
					<td>
						<%= Button("Button", "MOVE", "Button", "", "MOVE", "") %>
					</td>
					<td>
						<%= SelectBox(oConn, "sp_JobCompany_UserID_get " & Session("UserID"), "JobCompanyID", JobCompanyID, "EmailElement", "Job Folder") %>
					</td>
					<td>
						<%= Button("Button", "MOVE", "Button", "", "MOVE", "") %>
					</td>
					<% End If %>
				</tr>
				</table>
				
				
				<script type="text/javascript">

				<% If POP3EmailAccountID = "" Then %>
					
					$("#POP3EmailAccountID").prepend("<option value='SELECT EMAIL ACCOUNT' selected='selected'><%= Server.HTMLEncode("<  ") %>Select Email Account<%= Server.HTMLEncode("  >") %></option>");

				<% End If %>

					$("#POP3EmailAccountID").change
							(
								function()
								{
									var $POP3EmailAccountID = $('#POP3EmailAccountID').val();
									location.href = "<%= SCRIPT_NAME %>?POP3EmailAccountID=" + $POP3EmailAccountID;
								}
							);

					<% If POP3EmailAccountID <> "" AND POP3EmailFolderID = "" Then %>
					
						$("#POP3EmailFolderID").prepend("<option value='SELECT FOLDER' selected='selected'><%= Server.HTMLEncode("<  ") %>Select Folder<%= Server.HTMLEncode("  >") %></option>");
						$("#JobCompanyID").prepend("<option value='SELECT COMPANY' selected='selected'><%= Server.HTMLEncode("<  ") %>Select Company<%= Server.HTMLEncode("  >") %></option>");

						$("#POP3EmailFolderID").change
								(
									function()
									{
										var $POP3EmailAccountID = $('#POP3EmailAccountID').val();
										var $POP3EmailFolderID = $('#POP3EmailFolderID').val();
										location.href = "<%= SCRIPT_NAME %>?POP3EmailAccountID=" + $POP3EmailAccountID + "&POP3EmailFolderID=" + $POP3EmailFolderID;
									}
								);
					<% End If %>
				</script>

				&nbsp;<br />

				<% If EmailErrorMessage <> "" Then %>
				<div class="ErrorMessage"><%= EmailErrorMessage %></div>
				&nbsp;<br />
				<% End If %>
				
				<% If Template = "" Then %>
					<!-- #include file="templates/email.tem" -->
				<% ElseIf Template = "View" Then %>
					<!-- #include file="templates/email_view.tem" -->
				<% End If %>
				


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->