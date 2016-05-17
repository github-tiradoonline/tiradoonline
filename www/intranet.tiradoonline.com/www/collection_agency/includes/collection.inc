<% If CollectionAgencyID <> "" Then %>
<table cellpadding="5" class="GridViewAlteringRows" width="100%">
<tr bgcolor="<%= COLLECTION_AGENCY_THEME %>" style="color:#ffffff" align="right">
	<td style="font-size:15px"><b>Statements</b></td>
</tr>
<%
	sql = "SELECT * FROM Collection WHERE CollectionAgencyID = " & CollectionAgencyID & " ORDER BY CollectionStatementDate DESC"
	Set ors = oConn.Execute(sql)
	CollectionTotal = 0
	If NOT ors.EOF Then
		Do Until ors.EOF
			v_CollectionID = ors("CollectionID")
			v_CollectionStatementDate = ors("CollectionStatementDate")
			v_CollectionAmount = ors("CollectionAmount")
			CollectionTotal = CDbl(CollectionTotal) + CDbl(v_CollectionAmount)
%>
<tr class="GridViewRow" align="right">
	<td><a href="<%= SCRIPT_NAME %>?Template=<%= Template %>&CollectionAgencyID=<%= CollectionAgencyID %>&Action=Collection&CollectionID=<%= v_CollectionID %>"><%= FormatDateTime(v_CollectionStatementDate, 2) %>&nbsp;-&nbsp;$<%= FormatNumber(v_CollectionAmount, 2) %></a></td>
</tr>
<%
			ors.MoveNext
		Loop
		ors.Close
	End If
	Set ors = Nothing
%>
<tr bgcolor="<%= COLLECTION_AGENCY_THEME %>" style="color:#ffffff" align="right">
	<td bgcolor="<%= COLLECTION_AGENCY_THEME %>" style="color:#ffffff;font-size:15px"><b>Total:&nbsp;$<%= FormatNumber(CollectionTotal, 2) %></b></td>
</tr>
</table>
<%= Button("Button", "Add Statement", "Button", "", "Add Payment", "location.href='" & SCRIPT_NAME & "?Template=Collection&CollectionAgencyID=" & CollectionAgencyID & "&Action=Collection'") %>&nbsp;&nbsp;&nbsp;

<% End If %>