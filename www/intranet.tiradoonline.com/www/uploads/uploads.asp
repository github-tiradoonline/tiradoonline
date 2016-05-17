<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "UploadsTheme"
	PageThemeColor = UPLOADS_THEME
	PageTitle = "Uploads"
	HeaderTitle = "Uploads"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
%>


<!-- #include virtual="/includes/open_header.inc" -->

<script type="text/javascript">


</script>


<style type="text/css">
iframe {
  margin-top: 20px;
  margin-bottom: 30px;

  -moz-border-radius: 12px;
  -webkit-border-radius: 12px;
  border-radius: 12px;

  -moz-box-shadow: 4px 4px 14px #000;
  -webkit-box-shadow: 4px 4px 14px #000;
  box-shadow: 4px 4px 14px #000;

} </style>

<iframe src="http://local.uploads.tiradoonline.com/upload.aspx" width="100%" height="100%" frameborder="0" style="overflow: scroll;">

</iframe>


<%= formHidden("Template", Template) %>


<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
