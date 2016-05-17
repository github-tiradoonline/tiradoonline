<!-- 
****************************************************
	ACCOUNT FORM
****************************************************
 -->
 
<table cellspacing=0 cellpadding=3 border=0 width="100%">
<tr>
	<td>&nbsp;</td>
	<td class="ErrorMessage"><div id="CreateAccountErrorMessage" name="CreateAccountErrorMessage"><%= CreateAccountErrorMessage %></div></td>
</tr>
<tr>
	<td class="frm_label">Username:</td>
	<td>
		<%= formTextBox("CreateAccountUserName", "20", CreateAccountUserName, "HomeElement", "UserName", "Invalid Username") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">Password:</td>
	<td>
		<%= formPassword("CreateAccountPassword", "20", CreateAccountPassword, "HomeElement", "Password", "Invalid Password") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">Confirm&nbsp;Password:</td>
	<td>
		<%= formPassword("CreateAccountConfirmPassword", "20", CreateAccountConfirmPassword, "HomeElement", "Password", "Invalid Password") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">First&nbsp;name:</td>
	<td>
		<%= formTextBox("CreateAccountFirstName", "30", CreateAccountFirstName, "HomeElement", "First Name", "Invalid First Name") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">Last&nbsp;name:</td>
	<td>
		<%= formTextBox("CreateAccountLastName", "30", CreateAccountLastName, "HomeElement", "Last Name", "Invalid Last Name") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">Email:</td>
	<td>
		<%= formTextBox("CreateAccount_Email", "35", CreateAccount_Email, "HomeElement", "Email", "Invalid Email") %>
		<%= REQUIRED_ICON %>
	</td>
</tr>
<tr>
	<td class="frm_label">Mobile&nbsp;Email:</td>
	<td>
		<%= formTextBox("MobileEmail", "35", MobileEmail, "HomeElement", "Email", "Invalid Mobile Email Address") %>
	</td>
</tr>
<% If Instr(UCase(SCRIPT_NAME), "/DEFAULT.ASP") = 0 Then %>
<tr>
	<td class="frm_label">Address1:</td>
	<td>
		<%= formTextBox("Address1", "40", Address1, "HomeElement", "Address", "Invalid Address") %>
		<% If Address <> "" Then %>
				<%= ShowMap(Address) %>
		<% End If %>
	</td>
</tr>
<tr>
	<td class="frm_label"></td>
	<td>
		<%= formTextBox("Address2", "40", Address2, "HomeElement", "Address", "Invalid Address") %>
	</td>
</tr>
<tr>
	<td class="frm_label">City:</td>
	<td>
		<%= formTextBox("City", "40", City, "HomeElement", "City", "Invalid City") %>
	</td>
</tr>
<tr>
	<td class="frm_label">State:</td>
	<td>
		<%= SelectBox(oConn, "sp_States_get", "StateID", StateID, "HomeElement", "State") %>
	</td>
</tr>
<tr>
	<td class="frm_label">Zip&nbsp;Code:</td>
	<td>
		<%= formTextBox("ZipCode", "10", ZipCode, "HomeElement", "Zip Code", "Invalid Zip Code") %>
	</td>
</tr>
<tr>
	<td class="frm_label">Phone:</td>
	<td>
		<%= formTextBox("Phone", "30", Phone, "HomeElement", "Phone", "Invalid Phone") %>
	</td>
</tr>
<tr>
	<td class="frm_label">AIM:</td>
	<td>
		<%= formTextBox("AIM", "15", AIM, "HomeElement", "AIM", "Invalid AIM") %>
		<img src="/images/chat_icons/aim.gif" title="" width="20" height="20" hspace="0" vspace="0" border="0">
	</td>
</tr>
<tr>
	<td class="frm_label">Yahoo:</td>
	<td>
		<%= formTextBox("Yahoo", "15", Yahoo, "HomeElement", "Yahoo", "Invalid Yahoo") %>
		<img src="/images/chat_icons/yahoo.gif" title="" width="20" height="20" hspace="0" vspace="0" border="0">
	</td>
</tr>
<tr>
	<td class="frm_label">Hotmail:</td>
	<td>
		<%= formTextBox("Hotmail", "15", Hotmail, "HomeElement", "Hotmail", "Invalid Hotmail") %>
		<img src="/images/chat_icons/hotmail.gif" title="" width="20" height="20" hspace="0" vspace="0" border="0">
	</td>
</tr>
<tr>
	<td class="frm_label">Skype:</td>
	<td>
		<%= formTextBox("Skype", "15", Skype, "HomeElement", "Skype", "Invalid Skype") %>
		<img src="/images/chat_icons/skype.jpg" title="" width="20" height="20" hspace="0" vspace="0" border="0">
	</td>
</tr>
<tr>
	<td class="frm_label">Gmail:</td>
	<td>
		<%= formTextBox("Gmail", "15", Gmail, "HomeElement", "Gmail", "Invalid Gmail") %>
		<img src="/images/chat_icons/gmail.jpg" title="" width="20" height="20" hspace="0" vspace="0" border="0">
	</td>
</tr>
<% End If %>
<tr>
	<td>&nbsp;&nbsp;</td>
	<td>
		<%= Submit_Button("SubmitButton", SubmitButtonValue & " Account", "Button", "", SubmitButtonValue & " Account") %>&nbsp;&nbsp;
	</td>
	<td>&nbsp;&nbsp;</td>
</tr>
</table>

<!-- 
****************************************************
	END ACCOUNT FORM
****************************************************
 -->