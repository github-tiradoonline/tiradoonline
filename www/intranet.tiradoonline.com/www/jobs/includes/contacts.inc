				<%
					sql = "SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = " & JobCompanyID
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
					TotalContacts = ors.Fields(0).Value
					ors.Close
					Set ors = Nothing
					
					sql = "SELECT *, TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = " & JobCompanyID & ") FROM JobCompanyContact WHERE JobCompanyID = " & JobCompanyID & " ORDER BY JobCompanyContactLastName"
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
				%>
				<table cellpadding="5" class"GridViewAlteringRows" width="100%">
				<tr>
					<td class="JobsTheme" align="right">
						<b>Contacts&nbsp;(<%= TotalContacts %>)&nbsp;[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=company_contact&JobCompanyID=<%= JobCompanyID %>">New</a>&nbsp;]</b>
					</td>
				</tr>
				<%
					If NOT ors.EOF Then
						Do Until ors.EOF
							v_JobCompanyContactID = ors("JobCompanyContactID")
							v_JobCompanyContactFirstName = ors("JobCompanyContactFirstName")
							v_JobCompanyContactLastName = ors("JobCompanyContactLastName")
							v_JobCompanyContactTitle = ors("JobCompanyContactTitle")
							v_JobCompanyContactEmail = ors("JobCompanyContactEmail")
							v_JobCompanyContactEmail2 = ors("JobCompanyContactEmail2")
							v_JobCompanyContactWorkPhone = ors("JobCompanyContactWorkPhone")
							v_JobCompanyContactWorkPhone2 = ors("JobCompanyContactWorkPhone2")
							v_JobCompanyContactFax = ors("JobCompanyContactFax")
							v_JobCompanyContactCellPhone = ors("JobCompanyContactCellPhone")
							v_JobCompanyContactLinkedIn = ors("JobCompanyContactLinkedIn")
							v_JobCompanyContactTwitter = ors("JobCompanyContactTwitter")
							v_JobCompanyContactFacebook = ors("JobCompanyContactFacebook")
							v_JobCompanyContactGooglePlus = ors("JobCompanyContactGooglePlus")
							v_JobCompanyContactInstagram = ors("JobCompanyContactInstagram")
							v_JobCompanyContactSkype = ors("JobCompanyContactSkype")
							v_JobCompanyContactHotmail = ors("JobCompanyContactHotmail")
							v_JobCompanyContactYahoo = ors("JobCompanyContactYahoo")
							v_JobCompanyContactAIM = ors("JobCompanyContactAIM")
							v_JobCompanyContactGmail = ors("JobCompanyContactGmail")
							v_JobCompanyContactNotes = ors("JobCompanyContactNotes")
							v_CompanyContact = ""
							If v_JobCompanyContactLastName <> "" Then v_CompanyContact = v_CompanyContact & v_JobCompanyContactLastName & ",&nbsp;"
							If v_JobCompanyContactFirstName <> "" Then v_CompanyContact = v_CompanyContact & v_JobCompanyContactFirstName
				%>
				<tr class="GridViewRow">
					<td align="right">
						<div><a href="<%= SCRIPT_NAME %>?Template=company_contact&JobCompanyID=<%= JobCompanyID %>&JobCompanyContactID=<%= v_JobCompanyContactID %>" title="<%= v_CompanyContact %>"><%= HTMLFormat(v_CompanyContact) %></a></div>
						<div><%= HTMLFormat(v_JobCompanyContactTitle) %></div>
						<% If v_JobCompanyContactEmail <> "" Then %>
							<div><a href="mailto:<%= v_JobCompanyContactFirstName %> <%= v_JobCompanyContactLastName  %> <<%= v_JobCompanyContactEmail %>>"><%= v_JobCompanyContactEmail %></a></div>
						<% End If %>
						<% If v_JobCompanyContactEmail2 <> "" Then %>
							<div><a href="mailto:<%= v_JobCompanyContactFirstName %> <%= v_JobCompanyContactLastName  %> <<%= v_JobCompanyContactEmail2 %>>"><%= v_JobCompanyContactEmail2 %></a></div>
						<% End If %>
						<% If v_JobCompanyContactWorkPhone <> "" Then %>
							<div><b>W:</b>&nbsp;<%= HTMLFormat(v_JobCompanyContactWorkPhone) %></div>
						<% End If %>
						<% If v_JobCompanyContactWorkPhone2 <> "" Then %>
							<div><b>W2:</b>&nbsp;<%= HTMLFormat(v_JobCompanyContactWorkPhone2) %></div>
						<% End If %>
						<% If v_JobCompanyContactFax <> "" Then %>
							<div><b>F:</b>&nbsp;<%= HTMLFormat(v_JobCompanyContactFax) %></div>
						<% End If %>
						<% If v_JobCompanyContactCellPhone <> "" Then %>
							<div><b>C:</b>&nbsp;<%= HTMLFormat(v_JobCompanyContactCellPhone) %></div>
						<% End If %>
						<% If v_JobCompanyContactLinkedIn <> "" Then %>
							<a href="http://<%= FormatWebsite(v_JobCompanyContactLinkedIn) %>" target="_blank"><%= LINKEDIN_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactTwitter <> "" Then %>
							<a href="http://<%= FormatWebsite(v_JobCompanyContactTwitter) %>" target="_blank"><%= TWITTER_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactFacebook <> "" Then %>
							<a href="http://<%= FormatWebsite(v_JobCompanyContactFacebook) %>" target="_blank"><%= FACEBOOK_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactGooglePlus <> "" Then %>
							<a href="http://<%= FormatWebsite(v_JobCompanyContactGooglePlus) %>" target="_blank"><%= GOOGLEPLUS_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactInstagram <> "" Then %>
							<a href="http://<%= FormatWebsite(v_JobCompanyContactInstagram) %>" target="_blank"><%= INSTAGRAM_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactSkype <> "" Then %>
							<a title="<%= v_JobCompanyContactSkype %>"><%= SKYPE_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactHotmail <> "" Then %>
							<a title="<%= v_JobCompanyContactHotmail %>"><%= HOTMAIL_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactYahoo <> "" Then %>
							<a title="<%= v_JobCompanyContactYahoo %>"><%= YAHOO_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactAIM <> "" Then %>
							<a title="<%= v_JobCompanyContactAIM %>"><%= AIM_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<% If v_JobCompanyContactGmail <> "" Then %>
							<a title="<%= v_JobCompanyContactGmail %>"><%= GMAIL_ICON %></a>&nbsp;&nbsp;
						<% End If %>
						<div>
						[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=job_phonecall&JobCompanyID=<%= JobCompanyID %>&JobCompanyContactID=<%= v_JobCompanyContactID %>">ADD&nbsp;PHONE&nbsp;CALL</a>&nbsp;]&nbsp;
						[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=jobs&JobCompanyID=<%= JobCompanyID %>&JobCompanyContactID=<%= v_JobCompanyContactID %>">ADD&nbsp;JOB</a>&nbsp;]
						</div>
					</td>
				</tr>
				<%
							ors.MoveNext
						Loop
						ors.Close
				%>
			<% 
				Else
			%>
			<tr>
				<td colspan="2" class="ErrorMessage" bgcolor="#ffffff">
					No&nbsp;records&nbsp;found.
				</td>
			</tr>
			<%
				End If
				Set ors = Nothing
			%>
				</table>

