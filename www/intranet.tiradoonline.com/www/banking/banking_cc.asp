<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<link href="/includes/jquery/themes/base/jquery-ui.css" rel="stylesheet">
	<script src="/includes/jquery/jquery.js"></script>
	<script src="/includes/jquery/ui/jquery-ui.js"></script>
	<script src="/includes/jquery/ui/jquery.contextmenu.js"></script>
	<!-- #include virtual="/includes/css/global.css" -->
	<!-- #include virtual="/includes/js/functions.js" -->
	<title>Bankingintranet.tiradoonline.com: <%= Session("FullName") %></title>

	<style type="text/css">
	#container
	{
		text-align: center;
	}
	
	#EmailMeBox
	{
		text-align: center;
		text-shadow: 1px 1px #000000;
	}
	</style>
</head>

<body>

<form action="<%= SCRIPT_NAME %>" method="post" id="formCC" name="formCC">
<div id="container">
	<a href="/home.asp" title="Bankingintranet.tiradoonline.com"><img src="/images/header/logo_banner.gif" title="Bankingintranet.tiradoonline.com" width="572" height="82" border="0"></a>

	&nbsp;<br />	
	&nbsp;<br />	
	&nbsp;<br />	
	&nbsp;<br />	
	<div id="EmailMeBox">
	<table cellspacing=0 cellpadding=3 border=0 bgcolor="<%= BANKING_SUB_THEME %>" align="center">
	<tr>
		<td>
			<table cellspacing=0 cellpadding=5 border=0 bgcolor=#ffffff>
			<tr>
				<td colspan="4" bgcolor="<%= BANKING_SUB_THEME %>" align=center>
					&nbsp;&nbsp;&nbsp;<font color=#ffffff face="Verdana"><b>Email&nbsp;Me&nbsp;Monthly&nbsp;Statement</b></font>&nbsp;&nbsp;&nbsp;
					<div style="float:right">
						<%= Submit_Button("SubmitButton", "Email", "Button", "", "Email") %>&nbsp;&nbsp;
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<%= LOGO %>
				</td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td align=center valign="middle">
					&nbsp;<br>
					<% For x = 1 to 5 %>

				<%= formTextBox("CC" & x, "50", "", "BankingElement", "CC" & x, "Invalid Email Address") %>
				<p />
	
					<% Next %>
					&nbsp;<br>
				</td>
				<td>&nbsp;&nbsp;&nbsp;</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</div>
</div>
</form>
<script type="text/javascript">

    $('#EmailMeBox').fadeIn(3000);


</script>

</body>
</html>
