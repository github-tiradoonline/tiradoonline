<%
	Address = Trim(Request("Address"))
	APIKey = Application("APIKey")
	
	iFrameWidth = Application("MapWindowWidth") - 50
	iFrameHeight = Application("MapWindowHeight") - 50

	NewiFrameWidth = Application("MapWindowWidth") + 50
	NewiFrameHeight = Application("MapWindowHeight") + 50
%>
<html>
<head>
	<title><%= Address %></title>

	<link href="/includes/jquery/themes/base/jquery-ui.css" rel="stylesheet">
	<script src="/includes/jquery/jquery.js"></script>
	<script src="/includes/jquery/ui/jquery-ui.js"></script>
	<script src="/includes/jquery/ui/jquery.contextmenu.js"></script>
	<!-- #include virtual="/includes/css/global.css" -->

</head>

<body>

<table width="100%" height="100%">
<tr>
	<td valign="middle" align="center">
		<iframe
		  width="<%= iFrameWidth %>"
		  height="<%= iFrameHeight %>"
		  frameborder="0" 
		  style="border:0"
		  src="https://www.google.com/maps/embed/v1/place?key=<%= APIKey %>&q=<%= Address %>">
		</iframe>

	</td>
</tr>
</table>

<script type="text/javascript">

	$(document).ready
	(
		function()
		{
			$(window).resize
			(
				function()
				{
					window.resizeTo( <%= NewiFrameWidth %>, <%= NewiFrameHeight %> );	
				}
			)
		}
	)

</script>



</body>
</html>
