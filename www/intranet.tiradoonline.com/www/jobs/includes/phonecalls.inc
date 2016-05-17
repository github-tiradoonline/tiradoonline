				<%
					sql = "SELECT TotalPhoneCalls = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyID = " & JobCompanyID & ")"
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
					TotalPhoneCalls = ors.Fields(0).Value
					ors.Close
					Set ors = Nothing
					sql = "sp_JobCompanyPhoneCall_JobCompanyID_get " & JobCompanyID
					WriteDebugger sql, Debugging, 0
					Set ors = oConn.Execute(sql)
				%>
				<table cellpadding="5" class"GridViewAlteringRows" width="100%">
				<tr>
					<td class="JobsTheme" align="right">
						<b>Phone&nbsp;Calls&nbsp;(<%= TotalPhoneCalls %>)&nbsp;[&nbsp;<a href="<%= SCRIPT_NAME %>?Template=job_phonecall&JobCompanyID=<%= JobCompanyID %>">New</a>&nbsp;]</b>
					</td>
				</tr>
				<%
					If NOT ors.EOF Then
						Do Until ors.EOF
							v_JobCompanyPhoneCallID = ors("JobCompanyPhoneCallID")
							v_JobCompanyPhoneCallContactName = ors("JobCompanyPhoneCallContactName")
							v_JobCompanyPhoneCallDateTime = ors("JobCompanyPhoneCallDateTime")
							v_JobCompanyPhoneCallPhoneNumber = ors("JobCompanyPhoneCallPhoneNumber")
							v_JobCompanyPhoneCallType = ors("JobCompanyPhoneCallType")
							v_JobCompanyPhoneCallNotes = ors("JobCompanyPhoneCallNotes")
				%>
				<tr class="GridViewRow">
					<td>
					<a href="<%= SCRIPT_NAME %>?Template=job_phonecall&JobCompanyPhoneCallID=<%= v_JobCompanyPhoneCallID %>&JobCompanyID=<%= JobCompanyID %>" title="<%= v_JobCompanyPhoneCallNotes %>">
					<%= v_JobCompanyPhoneCallContactName %><br />
					<%= v_JobCompanyPhoneCallType %><br />
					<b><%= FormatDateTime(v_JobCompanyPhoneCallDateTime, 2) %>&nbsp;<%= FormatDateTime(v_JobCompanyPhoneCallDateTime, 3) %></b><br />
					<%= v_JobCompanyPhoneCallPhoneNumber %>
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
					No&nbsp;phone&nbsp;calls&nbsp;found.
				</td>
			</tr>
			<%
				End If
				Set ors = Nothing
				
			%>
				</table>
