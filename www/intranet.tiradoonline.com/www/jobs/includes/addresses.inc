				<%
					sql = "SELECT TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = " & JobCompanyID & ")"
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
					TotalAddresses = ors.Fields(0).Value
					ors.Close
					Set ors = Nothing

					sql = "SELECT a.*, b.State, TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = " & JobCompanyID & ") FROM JobCompanyAddress a, States b WHERE a.StateID = b.StateID AND a.JobCompanyID = " & JobCompanyID & " ORDER BY create_dt"
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
				%>
				<table cellpadding="5" class"GridViewAlteringRows" width="100%">
				<tr>
					<td class="JobsTheme">
						<b>Company&nbsp;Addresses&nbsp;(<%= TotalAddresses %>)&nbsp;[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=company_address&JobCompanyID=<%= JobCompanyID %>">New</a>&nbsp;]</b>
					</td>
				</tr>
				<%
					If NOT ors.EOF Then
						Do Until ors.EOF
							v_JobCompanyAddressID = ors("JobCompanyAddressID")
							v_JobCompanyAddress1 = ors("JobCompanyAddress1")
							v_JobCompanyAddress2 = ors("JobCompanyAddress2")
							v_JobCompanyAddressCity = ors("JobCompanyAddressCity")
							v_State = ors("State")
							v_JobCompanyAddressZipCode = ors("JobCompanyAddressZipCode")
							Address = v_JobCompanyAddress1 & " " & v_JobCompanyAddressCity & ", " & v_State & " " & v_JobCompanyAddressZipCode
							v_JobCompanyAddressPhone = ors("JobCompanyAddressPhone")
							v_JobCompanyAddressPhone2 = ors("JobCompanyAddressPhone2")
							v_JobCompanyAddressFax = ors("JobCompanyAddressFax")
							v_JobCompanyAddressEmail = ors("JobCompanyAddressEmail")

				%>
				<tr class="GridViewRow">
					<td>
						<div style="float:right">
							<%= ShowMap(Address) %>
						</div>

					<a href="<%= SCRIPT_NAME %>?Template=company_address&JobCompanyID=<%= JobCompanyID %>&JobCompanyAddressID=<%= v_JobCompanyAddressID %>">
					<% If v_JobCompanyAddress1 <> "" Then %>
						<%= v_JobCompanyAddress1 %><br />
					<% End If %>
					<% If v_JobCompanyAddress2 <> "" Then %>
						<%= v_JobCompanyAddress2 %><br />
					<% End If %>
					<% If v_JobCompanyAddressCity <> "" Then %>
						<%= v_JobCompanyAddressCity %>,&nbsp;
					<% End If %>
					<% If v_State <> "" Then %>
						<%= v_State %>&nbsp;
					<% End If %>
					<%= v_JobCompanyAddressZipCode %><br />
					<% If v_JobCompanyAddressPhone <> "" Then %>
						p: <%= v_JobCompanyAddressPhone %><br />
					<% End If %>
					<% If v_JobCompanyAddressPhone2 <> "" Then %>
						p2: <%= v_JobCompanyAddressPhone2 %><br />
					<% End If %>
					<% If v_JobCompanyAddressFax <> "" Then %>
						f: <%= v_JobCompanyAddressFax %><br />
					<% End If %>
					<% If v_JobCompanyAddressEmail <> "" Then %>
						<a href="mailto:<%= v_JobCompanyAddressEmail %>" target="_blank"><%= v_JobCompanyAddressEmail %></a>
					<% End If %>
					</a>
					<div style="text-align:right">
						[ <a href="javascript:DeleteItem('Are you sure you want to delete this address?', '<%= SCRIPT_NAME %>?SubmitButton=DeleteJobCompanyAddress&JobCompanyID=<%= JobCompanyID %>&JobCompanyAddressID=<%= v_JobCompanyAddressID %>')">DELETE</a> ]
					</div>
					&nbsp;<br>
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
