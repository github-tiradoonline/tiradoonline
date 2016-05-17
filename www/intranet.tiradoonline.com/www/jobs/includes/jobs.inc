				<%
					sql = "SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = " & JobCompanyID
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
					TotalJobs = ors.Fields(0).Value
					ors.Close
					Set ors = Nothing
					
					sql = "sp_Jobs_get " & JobCompanyID
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
				%>
				<table cellpadding="5" class"GridViewAlteringRows" width="100%">
				<tr>
					<td class="JobsTheme">
						<b><a href="<%= SCRIPT_NAME %>?Template=jobs&JobCompanyID=<%= JobCompanyID %>">Jobs&nbsp;(<%= TotalJobs %>)</a></b>
					</td>
				</tr>
				<%
					If NOT ors.EOF Then
						Do Until ors.EOF
							v_JobID = ors("JobID")
							v_JobClient = ors("JobClient")
							v_JobPosition = ors("JobPosition")
							v_JobDate = ors("JobDate")
							v_JobContactName = ors("JobCompanyContactName")
							v_JobCity = ors("JobCity")
							v_JobStateName = ors("JobStateName")
				%>
				<tr>
					<td class="GridViewRow" style="border-top: #000000 1px solid">
						<a href="<%= SCRIPT_NAME %>?Template=jobs&JobCompanyID=<%= JobCompanyID %>&JobID=<%= v_JobID %>" title="<%= v_CompanyName %>">
						<b><%= v_JobDate %>&nbsp;-&nbsp;

						<% If v_JobClient <> "" Then %>
						<%= v_JobClient %>
						<% End If %>

						<% If v_JobCity <> "" Then %>
						&nbsp;(<%= v_JobCity %>,&nbsp;<%= v_JobStateName %>)
						<% End If %>

						<br /><%= ors("JobCompanyContactName") %></b>
						<br />
						<%= v_JobPosition %></a><br />
						
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
