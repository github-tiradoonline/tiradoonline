<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "SnippetsTheme"
	PageThemeColor = SNIPPETS_THEME
	PageTitle = "Snippets"
	HeaderTitle = "Snippets"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	SnippetID = Trim(Request("SnippetID"))
	SnippetName = Trim(Request("SnippetName"))
	Snippet = Trim(Request("Snippet"))
	SnippetGroupName = Trim(Request("SnippetGroupName"))
	SnippetGroupID = Trim(Request("SnippetGroupID"))
	v_SnippetGroupID = Trim(Request("SnippetGroupID"))
	SubmitButton = UCase(Trim(Request("SubmitButton")))
	If SubmitButton = "Cancel" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template

	'If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
		If SubmitButton = "EMAILSNIPPET" Then
			sql = "sp_Snippets_SnippetID_get " & SnippetID
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				SnippetGroupName = ors("SnippetGroupName")
				SnippetName = ors("SnippetName")
				Snippet = ors("Snippet")
				ors.Close
				
				snippetText = ""
				snippetText = snippetText & "<table cellpadding=10 width=500>"
				snippetText = snippetText & "<tr valign=top><td align=right><b>Snippet&nbsp;Folder:</b></td><td>" & SnippetGroupName & "</td></tr>"
				snippetText = snippetText & "<tr valign=top><td align=right><b>Snippet&nbsp;Name:</b></td><td>" & SnippetName & "</td></tr>"
				snippetText = snippetText & "<tr valign=top><td align=right><b>Snippet:</b></td><td><pre>" & Snippet & "</pre></td></tr>"
				snippetText = snippetText & "</table>"

				ToEmail = Session("Email")
				AdministratorEmail = Application("AdministratorEmail")
				Subject = Application("ApplicationName") & " - Snippet: " & SnippetGroupName & "\" & SnippetName
				BodyText = snippetText
				
        		CC = Trim(Request("CC"))
				
				If CC <> "" Then 
					Response.Cookies("BankingEmailCC") = CC
					Response.Cookies("BankingEmailCC").Expires = Date + 20
				End If
				SendEmail ToEmail, AdministratorEmail, CC, Subject, BodyText, 1
				redirectURL = SCRIPT_NAME & "?SnippetID=" & SnippetID & "&SnippetsErrorMessage=" & Server.URLEncode("Snippet: (" & SnippetGroupName & "\" & SnippetName & ") emailed to " & Session("Email"))
				Response.Redirect redirectURL
			End If
			Set ors = Nothing	
		ElseIf SubmitButton = "CREATE" Then
			sql = "SELECT SnippetID FROM Snippets WHERE SnippetGroupID = " & SnippetGroupID & " AND SnippetName = '" & SQLEncode(SnippetName) & "'"
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If ors.EOF Then
				ors.Close
				Set ors = Nothing
				sql = "sp_Snippets_insert " & SnippetGroupID & ", '" & SQLEncode(SnippetName) & "', '" & SQLEncode(Snippet) & "'"
				WriteDebugger sql, Debugging, 0
				Set ors = oConn.Execute(sql)
				SnippetID = ors.Fields(0).value
				ors.Close
				Set ors = Nothing
				file_name = Server.MapPath("/teddy") & "\snippets\schema\" & SnippetGroupGet(SnippetGroupID) & "\" & SnippetName & ".hss"
				'FileWrite file_name, Snippet
				SnippetsErrorMessage = "Snippet added"
				Response.Redirect SCRIPT_NAME & "?SnippetGroupID=" & SnippetGroupID & "&SnippetID=" & SnippetID & "&SnippetsErrorMessage=" & Server.URLEncode(SnippetsErrorMessage)
			Else
				ors.Close
				Set ors = Nothing
				SnippetsErrorMessage = "Snippet already exists"
			End If
		ElseIf SubmitButton = "SAVE" Then
			sql = "SELECT SnippetID FROM Snippets WHERE SnippetName = '" & SnippetName & "' AND SnippetID <> " & SnippetID
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If ors.EOF Then
				ors.Close
				Set ors = Nothing
				'file_name = Server.MapPath("/teddy") & "\snippets\schema\" & SnippetGroupGet(SnippetGroupID) & "\" & SnippetName & ".hss"
				'FileWrite file_name, Snippet
				sql = "UPDATE Snippets SET " & _
					  "SnippetGroupID = " & SnippetGroupID & ", " & _
					  "SnippetName = '" & SnippetName & "', " & _
					  "Snippet = '" & Replace(Snippet, "'", "''") & "', " & _
					  "update_dt = getdate() " & _
					  "WHERE SnippetID = " & SnippetID
				WriteDebugger sql, Debugging, 0
				oConn.Execute sql
				Session("SnippetGroupID") = SnippetGroupID
				SnippetsErrorMessage = "Snippet updated"
				Response.Redirect SCRIPT_NAME & "?SnippetID=" & SnippetID & "&SnippetsErrorMessage=" & Server.URLEncode(SnippetsErrorMessage)
			Else
				ors.Close	
				Set ors = Nothing
				SnippetsErrorMessage = "Snippet '" & SnippetName & "' already exists"
			End If
		ElseIf SubmitButton = "DELETE" Then
			sql = "SELECT a.SnippetGroupName, b.SnippetName FROM SnippetGroups a, Snippets b WHERE a.SnippetGroupID = b.SnippetGroupID AND b.SnippetID = " & SnippetID
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			'file_name = Server.MapPath("/") & "\snippets\schema\" & SnippetGroupGet(SnippetGroupID) & "\" & SnippetName & ".hss"
			ors.Close
			Set ors = Nothing
			sql = "sp_Snippets_delete " & SnippetID
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			
			'FileDelete file_name
			SnippetsErrorMessage = "Snippet deleted"
			Response.Redirect SCRIPT_NAME & "?SnippetsErrorMessage=" & Server.URLEncode(SnippetsErrorMessage)
		ElseIF SubmitButton = "CREATENEWGROUP" Then
			sql = "SELECT SnippetGroupName FROM SnippetGroups WHERE SnippetGroupName = '" & SQLEncode(SnippetGroupName) & "' AND UserID = " & Session("UserID")
			WriteDebugger sql, Debugging, 0
			Set ors = oConn.Execute(sql)
			If ors.EOF Then
				ors.Close
				Set ors = Nothing
				sql = "sp_SnippetGroups_insert " & Session("UserID") & ", '" & SQLEncode(SnippetGroupName) & "'"
				WriteDebugger sql, Debugging, 0
				Set ors = oConn.Execute(sql)
				SnippetGroupID = ors.Fields(0).value
				ors.Close
				Set ors = Nothing
				SnippetsErrorMessage = "Snippet Group Created"
				Response.Redirect SCRIPT_NAME & "?SnippetsErrorMessage=" & Server.URLEncode(SnippetsErrorMessage) & "&SnippetGroupID=" & SnippetGroupID
			Else
				SnippetsErrorMessage = "Snippet Group " & SnippetGroupName & " exists."
				Response.Redirect SCRIPT_NAME & "?SnippetsErrorMessage=" & Server.URLEncode(SnippetsErrorMessage)
			End If
		End If
	'End If
	
 %>
<!-- #include virtual="/includes/open_header.inc" -->

<form action="<%= SCRIPT_NAME %>" method="post" id="formSnippet" name="formSnippet">
	<table>
	<tr valign="top">
		<td width="200">
		<%= Button("Button", "Create New Folder", "Button", "", "Create New Folder", "promptSnippetGroup()") %>		
		<p>

<%
	TotalSnippetGroups = 0
	sql = "sp_SnippetGroups_get " & Session("UserID")
	Set SnippetGroups = oConn.Execute(sql)
	If NOT SnippetGroups.EOF Then
%>
	<ul id="SnippetMenu">
<%
		Do Until SnippetGroups.EOF
			SnippetGroupID = SnippetGroups("SnippetGroupID")
			SnippetGroupName = SnippetGroups("SnippetGroupName")
			SnippetFolder = Server.MapPath("/") & "\snippets\schema\" & SnippetGroupName
			TotalSnippets = SnippetGroups("TotalSnippets")
			TotalSnippetGroups = TotalSnippetGroups + 1
%>	
		<% If TotalSnippets > 0 Then %>
    	<li style="z-index:1">
	        <a href="javascript:void(null)" onClick="showSnippet('<%= SnippetGroupName %>')"><%= SnippetGroupName %> (<%= TotalSnippets %>)</a>
    	    <ul style="z-index:1">
	            <li style="z-index:1"><a href="<%= SCRIPT_NAME %>?SnippetGroupID=<%= SnippetGroupID %>">[&nbsp;Create&nbsp;New&nbsp;Snippet&nbsp;]</a></li>
			<%
				sql = "sp_Snippets_get " & SnippetGroupID
				Set ors = oConn.Execute(sql)
				Do Until ors.EOF
					v_SnippetID = ors("SnippetID")
					SnippetName = ors("SnippetName")
			%>
	            <li style="z-index:1"><a href="<%= SCRIPT_NAME %>?SnippetID=<%= v_SnippetID %>"><%= SnippetName %></a></li>
			<%
					ors.MoveNext
				Loop
				ors.Close
				Set ors = Nothing
			%>
      		</ul>
    	</li>
		<% Else %>
		<li style="z-index:1">
		    <a href="javascript:void(null)" onClick="showSnippet('<%= SnippetGroupName %>')"><%= SnippetGroupName %>&nbsp;(<%= TotalSnippets %>)</a>
			<ul style="z-index:1">
				<li style="z-index:1"><a href="<%= SCRIPT_NAME %>?SnippetGroupID=<%= SnippetGroupID %>">[&nbsp;Create&nbsp;New&nbsp;Snippet&nbsp;]</a></li>
			</ul>
		</li>
		<% End If %>
	
<%
			SnippetGroups.MoveNext
		Loop
		SnippetGroups.Close
%>
	</ul>
<% Else %>
	<div class="ErrorMessage">No Snippet Folders found.</div>
<% End If %>
		</td>

		<!-- RIGHT COLUMN -->
		<td>&nbsp;
		
		<%
			If TotalSnippetGroups > 0 Then
			 	If Trim(Request("SnippetID")) <> "" Then 
					sql = "sp_Snippets_SnippetID_get " & Trim(Request("SnippetID"))
					Set ors = oConn.Execute(sql)
					If NOT ors.EOF Then
						v_SnippetName = ors("SnippetName")
						v_SnippetGroupID = ors("SnippetGroupID")
						v_Snippet = ors("Snippet")
					End If
				End If
		%>
		<table cellpadding="3">
		<% If SnippetsErrorMessage <> "" Then %>
		<tr valign="top">
			<td colspan="2" class="ErrorMessage"><%= SnippetsErrorMessage %></td>
		</tr>
		<% End If %>
		<tr valign="top">
			<td><b>Group:</b><br />
				<%= SelectBox(oConn, "SELECT SnippetGroupID, SnippetGroupName FROM SnippetGroups WHERE UserID = "& Session("UserID") & " ORDER BY SnippetGroupName ", "SnippetGroupID", v_SnippetGroupID,  "SnippetElement", "Group") %> </td>
				<% 
					SubmitButtonValue = "Save"
					If Trim(Request("SnippetID")) = "" Then SubmitButtonValue = "create"
				%>
				<% If Trim(Request("SnippetID")) <> "" Then %>
					<div style="text-align:right">
						<%= Button("Button", "Email Snippet", "Button", "clear:both;", "Email Snippet", "EmailSnippet(" & Trim(Request("SnippetID")) & ")") %>
						&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;
						<%= Button("Button", "Delete", "DeleteButton", "padding-bottom:10px;", "Delete", "DeleteSnippet(" & Trim(Request("SnippetID")) & ")") %>
					</div>
				<% End If %>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<b>Snippet&nbsp;Name:</b><br />
				<%= formTextBox("SnippetName", "30", v_SnippetName, "SnippetElement", "Snippet Name", "Invalid Snippet Name") %><%= REQUIRED_ICON %>
			</td>
		</tr>
		<tr valign="top">
			<td><b>Snippet:</b><%= REQUIRED_ICON %><br />
			<%= formTextArea("Snippet", v_Snippet, "600", "200", "SnippetElement", "Snippet", "Invalid Snippet") %>
		</tr>	
		<tr>
			<td colspan="2">
				<%= Submit_Button("SubmitButton", SubmitButtonValue, "Button", "float:right", SubmitButtonValue) %>&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		</table>
		
		<% End If %>

		</td>
	</tr>
	</table>
	
    <script type="text/javascript">
        $("#SnippetMenu").menu();
    </script>

<%= formHidden("SnippetID", SnippetID) %>

</form>
	
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
