<% If CreditCardID <> "" Then %>
<table cellpadding="5" class="GridViewAlteringRows" width="100%">
<tr bgcolor="<%= CREDITCARDS_THEME %>" style="color:#ffffff" align="right">
	<td style="font-size:15px"><b>Payments</b></td>
</tr>
<%
	sql = "SELECT * FROM CreditCardPayment WHERE CreditCardID = " & CreditCardID & " ORDER BY CreditCardPaymentDate DESC"
	Set ors = oConn.Execute(sql)
	CreditCardPaymentTotal = 0
	If NOT ors.EOF Then
		Do Until ors.EOF
			v_CreditCardPaymentID = ors("CreditCardPaymentID")
			v_CreditCardPaymentDate = ors("CreditCardPaymentDate")
			v_CreditCardPaymentAmount = ors("CreditCardPaymentAmount")
			CreditCardPaymentTotal = CDbl(CreditCardPaymentTotal) + CDbl(v_CreditCardPaymentAmount)
%>
<tr class="GridViewRow" align="right">
	<td><a href="<%= SCRIPT_NAME %>?Template=<%= Template %>&CreditCardID=<%= CreditCardID %>&Action=<%= Action %>&CreditCardPaymentID=<%= v_CreditCardPaymentID %>"><%= FormatDateTime(v_CreditCardPaymentDate, 2) %>&nbsp;-&nbsp;$<%= FormatNumber(v_CreditCardPaymentAmount, 2) %></a></td>
</tr>
<%
			ors.MoveNext
		Loop
		ors.Close
	End If
	Set ors = Nothing
%>
<tr bgcolor="<%= CREDITCARDS_THEME %>" align="right">
	<td style="color:#ffffff;font-size:15px" bgcolor="<%= CREDITCARDS_THEME %>"><b>Total:&nbsp;$<%= FormatNumber(CreditCardPaymentTotal, 2) %></b></td>
</tr>
</table>
<%= Button("Button", "Add Payment", "Button", "", "Payment", "location.href='" & SCRIPT_NAME & "?Template=CreditCards&Action=CreditCardPayment&CreditCardID=" & CreditCardID & "'") %>&nbsp;&nbsp;&nbsp;

<% End If %>