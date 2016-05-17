<%= Button("Button", "Addresses (" & TotalAddresses & ")", "Button", "", "Addresses (" & TotalAddresses & ")", "location.href='" & SCRIPT_NAME & "?Template=company_address&JobCompanyID=" & JobCompanyID & "'") %>
<%= Button("Button", "Contacts (" & TotalContacts & ")", "Button", "Contacts (" & TotalContacts & ")", "", "location.href='" & SCRIPT_NAME & "?Template=company_contact&JobCompanyID=" & JobCompanyID & "'") %>
<% If TotalContacts > 0 Then %>
	<%= Button("Button", "Jobs (" & TotalJobs & ")", "Button", "Contacts (" & TotalContacts & ")", "", "location.href='" & SCRIPT_NAME & "?Template=jobs&JobCompanyID=" & JobCompanyID & "'") %>
	<%= Button("Button", "Phone Calls (" & TotalPhoneCalls & ")", "Button", "Phone Calls (" & TotalPhoneCalls & ")", "", "location.href='" & SCRIPT_NAME & "?Template=job_phonecall&JobCompanyID=" & JobCompanyID & "'") %>
<% End If %>
<%= Button("Button", "Interviews (" & TotalInterviews & ")", "Button", "Interviews (" & TotalInterviews & ")", "", "location.href='" & SCRIPT_NAME & "?Template=job_interview&JobCompanyID=" & JobCompanyID & "'") %>
