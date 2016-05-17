				<%
					sql = "SELECT TotalInterviews = (SELECT COUNT(*) FROM JobInterview WHERE JobCompanyID = " & JobCompanyID & ")"
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
					TotalInterviews = ors.Fields(0).Value
					ors.Close
					Set ors = Nothing
					
					sql = "sp_JobInterview_JobCompanyID_get " & JobCompanyID
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
				%>
				<table cellpadding="5" class"GridViewAlteringRows" width="100%">
				<tr>
					<td class="JobsTheme" align="right">
						<b>Interviews&nbsp;(<%= TotalInterviews %>)&nbsp;[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=job_interview&JobCompanyID=<%= JobCompanyID %>">New</a>&nbsp;]</b>
					</td>
				</tr>
				<%
					If NOT ors.EOF Then
						Do Until ors.EOF
							v_JobInterviewID = ors("JobInterviewID")
							v_JobInterviewDateTime = ors("JobInterviewDateTime")
							v_JobInterviewClientName = ors("JobInterviewClientName")
							v_JobInterviewContactName = ors("JobInterviewContactName")
							v_JobInterviewID = ors("JobInterviewID")
							v_JobInterviewAddress1 = ors("JobInterviewAddress1")
							v_JobInterviewAddress2 = ors("JobInterviewAddress2")
							v_JobInterviewCity = ors("JobInterviewCity")
							v_JobInterviewType = ors("JobInterviewType")
							v_State = ors("State")
							v_JobInterviewZipCode = ors("JobInterviewZipCode")
							Address = v_JobInterviewAddress1 & " " & v_JobInterviewCity & ", " & v_State & " " & v_JobInterviewZipCode
				%>
				<tr class="GridViewRow">
					<td>
			<div style="float:right">
				<%= ShowMap(Address) %>
			</div>
					
					
					<a href="<%= SCRIPT_NAME %>?Template=job_interview&JobInterviewID=<%= v_JobInterviewID %>&JobCompanyID=<%= JobCompanyID %>">
					<b><%= FormatDateTime(v_JobInterviewDateTime, 2) %>&nbsp;<%= FormatDateTime(v_JobInterviewDateTime, 3) %></b><br />
					<b><%= v_JobInterviewType %></b><br />
					<b><%= v_JobInterviewClientName %></b><br />
					<%= v_JobInterviewContactName %><br />
					<% If v_JobInterviewAddress1 <> "" Then %>
						<%= v_JobInterviewAddress1 %><br />
					<% End If %>
					<% If v_JobInterviewAddress2 <> "" Then %>
						<%= v_JobInterviewAddress2 %><br />
					<% End If %>
					<% If v_JobInterviewAddressCity <> "" Then %>
						<%= v_JobInterviewAddressCity %>,&nbsp;
					<% End If %>
					<% If v_JobInterviewState <> "" Then %>
						<%= v_JobInterviewState %>&nbsp;
					<% End If %>
					<%= v_JobInterviewAddressZipCode %>
					</a>
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
					No&nbsp;interviews&nbsp;found.
				</td>
			</tr>
			<%
				End If
				Set ors = Nothing
				
			%>
				</table>
