<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "CreditCardsTheme"
	PageThemeColor = CREDITCARDS_THEME
	PageTitle = "Credit Cards"
	HeaderTitle = "Credit Cards"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	CreditCardID = Trim(Request("CreditCardID"))
	CreditCardName = Trim(Request("CreditCardName"))
	CreditLimit = Trim(Request("CreditLimit"))
	If CreditLimit = "" Then CreditLimit = 0
	MinimumPayment = Trim(Request("MinimumPayment"))
	If MinimumPayment = "" Then MinimumPayment = 0
	CreditAvailable = Trim(Request("CreditAvailable"))
	If CreditAvailable = "" Then CreditAvailable = 0
	ClosingDate = Trim(Request("ClosingDate"))
	DueDate = Trim(Request("DueDate"))
	Percentage = Trim(Request("Percentage"))
	If Percentage = "" Then Percentage = 0.0
	'Payments = Trim(Request("Payments"))
	'If Payments = "" Then Payments = 0.0
	OrderBy = Trim(Request("OrderBy"))
	If OrderBy = "" Then OrderBy = "CreditCardName"

	CreditCardPaymentID = Trim(Request("CreditCardPaymentID"))
	CreditCardPaymentDate = Trim(Request("CreditCardPaymentDate"))
	CreditCardPaymentAmount = Trim(Request("CreditCardPaymentAmount"))
	CreditCardPaymentComment = Trim(Request("CreditCardPaymentComment"))
	
	If SubmitButton = "Delete" Then
		sql = "DELETE FROM CreditCard WHERE CreditCardID = " & CreditCardID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "Create Credit Card" Then
		sql = "INSERT INTO CreditCard (UserID, CreditCardName, CreditLimit, MinimumPayment, CreditAvailable, ClosingDate, DueDate, Percentage) VALUES (" & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(CreditCardName) & "', " & _
			  CreditLimit & ", " & _
			  MinimumPayment & ", " & _
			  CreditAvailable & ", " & _
			  ClosingDate & ", " & _
			  DueDate & ", " & _
			  Percentage & ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card '" & CreditCardName & "' added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "Save Credit Card" Then
		sql = "UPDATE CreditCard SET " & _
			  "CreditCardName = '" & SQLEncode(CreditCardName) & "', " & _
			  "CreditLimit = " & CreditLimit & ", " & _
			  "MinimumPayment = " & MinimumPayment & ", " & _
			  "CreditAvailable = " & CreditAvailable & ", " & _
			  "ClosingDate = " & SQLEncode(ClosingDate) & ", " & _
			  "DueDate = " & SQLEncode(DueDate) & ", " & _
			  "Percentage = " & Percentage & " " & _
			  "WHERE CreditCardID = " & CreditCardID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card '" & CreditCardName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "Create Credit Card Payment" Then
		sql = "INSERT INTO CreditCardPayment (CreditCardID, CreditCardPaymentDate, CreditCardPaymentAmount, CreditCardPaymentComment) VALUES (" & _
			  CreditCardID & ", " & _
			  "'" & SQLEncode(CreditCardPaymentDate) & "', " & _
			  CreditCardPaymentAmount & ", " & _
			  "'" & SQLEncode(CreditCardPaymentComment) & "')"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card Payment added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=CreditCardPayment&CreditCardID=" & CreditCardID & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "Save Credit Card Payment" Then
		sql = "UPDATE CreditCardPayment SET " & _
			  "CreditCardPaymentDate = '" & SQLEncode(CreditCardPaymentDate) & "', " & _
			  "CreditCardPaymentAmount = " & CreditCardPaymentAmount & ", " & _
			  "CreditCardPaymentComment = '" & SQLEncode(CreditCardPaymentComment) & "' " & _
			  "WHERE CreditCardPaymentID = " & CreditCardPaymentID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card Payment saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=CreditCardPayment&CreditCardID=" & CreditCardID & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "DeleteCreditCardPayment" Then
		sql = "DELETE FROM CreditCardPayment WHERE CreditCardPaymentID = " & CreditCardPaymentID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Credit Card Payment deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&Action=CreditCardPayment&CreditCardID=" & CreditCardID & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	End If	
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<form action="<%= SCRIPT_NAME %>" method="post">
				<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
				<tr>
					<td class="frm_label"><b>&nbsp;&nbsp;&nbsp;Credit&nbsp;Card&nbsp;Name:</b></font>&nbsp;</td>
					<td>
						<%= formTextBox("CreditCard_Name", "40", "", "CreditCardsElement", "Credit Card Name", "Invalid Credit Card Name") %>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff">
						<tr valign=top>
							<td>
								<%= Button("Button", "Create Credit Card", "Button", "", "Create Credit Card", "formCreditCardCreate()") %>
							</td>
							<td>
								<%= Button("Button", "View All Credit Card Info", "Button", "", "", "location.href='" & SCRIPT_NAME & "?Template=CreditCards'") %>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<%= formHidden("Template", Template) %>
				</form>
				&nbsp;<br />
				<% If CreditCardErrorMessage <> "" Then %>
				<div class="ErrorMessage"><%= CreditCardErrorMessage %></div>
				&nbsp;<br />
				<% End If %>
				<% If Template = "" Then %>
					<% CreditCardImageID = "home" %>
					<!-- #include file="templates/home.tem" -->
				<% ElseIf Template = "CreditCards" Then %>
					<!-- #include file="templates/creditcards.tem" -->
				<% End If %>
				


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->