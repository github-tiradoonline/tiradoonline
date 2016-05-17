<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	Function GetVirtualDirectory(FullMediaFileName)
		v_FullMediaFileName = FullMediaFileName
		v_FullMediaFileName = Server.MapPath("/" & Session("UserID"))
		GetVirtualDirectory(v_FullMediaFileName)
	End Function
	
	MediaFileType = "music"
	
	If SubmitButton <> "" Then
		fileArray = Split(Request.Form("MediaFileName"), ",")
		ErrorMessage = "<div style=""color:#ff0000;font-weight:bold;"">Files:"
		For x = 0 To UBound(fileArray)
			On Error Resume Next
			sql = "sp_MediaFile_MediaFileID_get " & _
				Session("UserID") & ", " & _
				fileArray(x)
				
			Set ors = oConn.Execute(sql)
			If NOT ors.EOF Then
				filename = ors("MediaFileName")
				filedirectoryname = ors("MediaFileDirectory")
				fullfilename = filedirectoryname & "\" & filename
				FileDelete fullfilename
				sql = "sp_MediaFile_MediaFileID_delete " & _
					Session("UserID") & ", " & _
					fileArray(x)
				'Response.Write sql
				'Response.End
				oConn.Execute sql
				ors.Close
			End If
			Set ors = Nothing

				If Err.Number = 0 Then 
				ErrorMessage = ErrorMessage & "<li>" & fullfilename & "</li>"
			End If
			Err.Clear
		Next
		ErrorMessage = ErrorMessage & " DELETED</div>"
		redirectURL = SCRIPT_NAME & "?ErrorMessage=" & Server.URLEncode(ErrorMessage)
		Response.Redirect redirectURL
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%= UCase(MediaFileType) %></title>
	<link href="/includes/bootstrap/css/bootstrap.css" rel="stylesheet">
	<script src="/includes/bootstrap/js/bootstrap.js"></script>
	<script src="/includes/jquery/jquery.js"></script>

	<!-- GLOBAL -->
</head>

<body>

<form action="<%= SCRIPT_NAME %>" method="post">


<div class="container">
<div class="ErrorMessage">
	<%= ErrorMessage %>
</div>
<%
	sql = "sp_MediaFile_Duplicates_get " & _
			Session("UserID") & ", " & _
			"'music'"
		
	Set ors = oConn.Execute(sql)
%>


<%
	If NOT ors.EOF Then
%>
<input type="submit" id="SubmitButton" name="SubmitButton" class="DeleteButton" style="display:none;text-align:center;margin:20px;" value="DELETE" />
<table bgcolor="#000000" cellpadding="10" cellspacing="10" class="GridViewAlteringRows shadow">
<tr bgcolor="#dddddd" style="color:#ffffff">
	<td>Media&nbsp;File</td>
	<td>Duplicates</td>
</tr>
<% 
			If Trim(Request("MediaFileName")) <> "" Then 
%>
<tr bgcolor="#dddddd" style="border:1px solid #000">
	<td class="GridViewRow shadow" valign="top" style="padding: 10px">
		<%
				sql = "sp_MediaFile_MediaFileName_get " & _
						Session("UserID") & ", " & _
						"'" & SQLEncode(Trim(Request("MediaFileName"))) & "'"
						
				Set ors2 = oConn.Execute(sql)
				If NOT ors2.EOF Then
					Do Until ors2.EOF
						MediaFileID = ors2("MediaFileID")
						FullMediaFileName = ors2("MediaFileDirectory") & "\" & ors2("MediaFileName")
		%>
		<li>
			<a href="file://<%= FullMediaFileName %>" target="_blank"><%= FullMediaFileName %></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="checkbox" id="MediaFileName" name="MediaFileName" style="float:right" value="<%= MediaFileID %>" />
		</li>
		<%
						ors2.MoveNext
					Loop
					ors2.Close
				End If
				Set ors2 = Nothing
		%>
	</td>
</tr>
<%
			End If 
%>
<%
		counter = 1
		Do Until ors.EOF
			bgcolor = "#ffffff"
			if counter mod 2 = 0 Then bgcolor = "#ddddddd"
			MediaFileName = ors("MediaFileName") 
			FullMediaFileName = ors("MediaFileDirectory") & "\" & ors("MediaFileName")
			Duplicates = ors("Duplicates")
			
			FullMediaFileName = GetVirtualDirectory(FullMediaFileName)
%>
<tr class="GridViewRow" bgcolor="<%= bgcolor %>" valign="top">
	<td class="GridViewRow shadow" valign="top" style="padding: 10px">
		<a href="<%= FullMediaFileName %>"><%= MediaFileName %></a>
	</td>
	<td align="center"><%= Duplicates %></td>
</tr>
<%
			counter = counter + 1
			ors.MoveNext
		Loop
		ors.Close
%>
</table>
<%
	Else
%>
<div class="ErrorMessage">
	No Duplicates found
</div>

<%
	End if
	Set ors = Nothing
%>

</div>

</form>

<script type="text/javascript">

	$('input').click
	(
		function()
		{
			if($('form input[type=checkbox]:checked').size() > 0)
				$('#SubmitButton').fadeIn(1000);
			else
				$('#SubmitButton').hide();
		}
	);
</script>



</body>
</html>
<!-- #include virtual="/includes/close_connection.inc" -->
