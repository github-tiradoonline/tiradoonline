<%
	Address = Trim(Request("Address"))
	APIKey = Application("APIKey")
	Address = "1234 Olmstead Ave Bronx, NY 10462"
%>
<html>
<head>
	<title><%= Address %></title>

	<style type="text/css">
		body 
		{
		    background-repeat: no-repeat;
		    background-attachment: fixed;
		    background-position: center; 
			background-image:url('/images/background/logo.gif');	
		}
	</style>

</head>

<body>

<iframe
  width="600"
  height="450"
  frameborder="0" 
  style="border:0"
  src="https://www.google.com/maps/embed/v1/place?key=<%= APIKey %>&q=<%= Address %>">
</iframe>


</body>
</html>
