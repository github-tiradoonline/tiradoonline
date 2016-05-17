<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "BankingMonthlyExpensesTheme"
	PageThemeColor = BankingMonthlyExpenseS_THEME
	PageTitle = "Monthly Expenses"
	HeaderTitle = "Monthly Expenses"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	BankingMonthlyExpenseID = Trim(Request("BankingMonthlyExpenseID"))
	BankingMonthlyExpenseName = Trim(Request("BankingMonthlyExpenseName"))
	BankingMonthlyExpenseAmount = Trim(Request("BankingMonthlyExpenseAmount"))
	If BankingMonthlyExpenseAmount = "" Then BankingMonthlyExpenseAmount = 0
	BankingMonthlyExpenseBillDate = Trim(Request("BankingMonthlyExpenseBillDate"))
	If BankingMonthlyExpenseBillDate = "" Then BankingMonthlyExpenseBillDate = 1
	
	If SubmitButton = "Delete" Then
		sql = "DELETE FROM BankingMonthlyExpense WHERE BankingMonthlyExpenseID = " & BankingMonthlyExpenseID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		CreditCardErrorMessage = Server.URLEncode("Monthly Expense deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&CreditCardErrorMessage=" & CreditCardErrorMessage
	ElseIf SubmitButton = "Create Monthly Expense" Then
		sql = "INSERT INTO BankingMonthlyExpense (UserID, BankingMonthlyExpenseName, BankingMonthlyExpenseAmount, BankingMonthlyExpenseBillDate) VALUES (" & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(BankingMonthlyExpenseName) & "', " & _
			  BankingMonthlyExpenseAmount & ", " & _
			  BankingMonthlyExpenseBillDate & ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		BankingMonthlyExpenseErrorMessage = Server.URLEncode("Monthly Expense '" & BankingMonthlyExpenseName & "' added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&BankingMonthlyExpenseErrorMessage=" & BankingMonthlyExpenseErrorMessage
	ElseIf SubmitButton = "Save Monthly Expense" Then
		sql = "UPDATE BankingMonthlyExpense SET " & _
			  "BankingMonthlyExpenseName = '" & SQLEncode(BankingMonthlyExpenseName) & "', " & _
			  "BankingMonthlyExpenseAmount = " & BankingMonthlyExpenseAmount & ", " & _
			  "BankingMonthlyExpenseBillDate = " & BankingMonthlyExpenseBillDate & " " & _
			  "WHERE BankingMonthlyExpenseID = " & BankingMonthlyExpenseID
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		BankingMonthlyExpenseErrorMessage = Server.URLEncode("Monthly Expense '" & BankingMonthlyExpenseName & "' saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&BankingMonthlyExpenseErrorMessage=" & BankingMonthlyExpenseErrorMessage
	End If	
%>

<!-- #include virtual="/includes/open_header.inc" -->


				<form action="<%= SCRIPT_NAME %>" method="post">
				<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff" width="100%">
				<tr>
					<td class="frm_label"><b>&nbsp;&nbsp;&nbsp;Monthly&nbsp;Expense:</b></font>&nbsp;</td>
					<td>
						<%= formTextBox("BankingMonthlyExpense_Name", "40", "", "BankingMonthlyExpensesElement", "Credit Card Name", "Invalid Monthly Expense") %>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellspacing=0 cellpadding=2 border=0 bgcolor="#ffffff">
						<tr valign=top>
							<td>
								<%= Button("Button", "Create Monthly Expense", "Button", "BankingMonthlyExpensesElement", "Create Monthly Expense", "formBankingMonthlyExpenseCreate()") %>
							</td>
							<td>
								<%= Button("Button", "View All Monthly Expenses  Info", "Button", "BankingMonthlyExpensesElement", "View All Monthly Expenses", "location.href='" & SCRIPT_NAME & "?Template=MonthlyExpenses'") %>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<%= formHidden("Template", Template) %>
				</form>
				&nbsp;<br />
				<% If BankingMonthlyExpenseErrorMessage <> "" Then %>
				<div class="ErrorMessage"><%= BankingMonthlyExpenseErrorMessage %></div>
				&nbsp;<br />
				<% End If %>
				<% If Template = "" Then %>
					<% BankingMonthlyExpenseImageID = "home" %>
					<!-- #include file="templates/home.tem" -->
				<% ElseIf Template = "MonthlyExpenses" Then %>
					<!-- #include file="templates/monthly_expenses.tem" -->
				<% End If %>
				


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->