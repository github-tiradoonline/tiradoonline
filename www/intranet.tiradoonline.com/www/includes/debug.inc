&nbsp;<br />
&nbsp;<br />

<table cellpadding="3" cellspacing="1" border=0 bgcolor="#0000000" width="600">
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>Database</b></td>
</tr>
<tr bgcolor="#ffffff">
	<td>MISNY10\ACCPAC</td>
	<td><%= ACCPACConnectionString %></td>
</tr>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>SQL</b></td>
</tr>
<tr bgcolor="#ffffff">
	<td colspan="2"><%= TotalSQL %></td>
</tr>
<tr bgcolor="#ff00ff">
	<td>Intranet</td>
	<td><%= IntranetConnectionString %></td>
</tr>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>Form</b></td>
</tr>
<%
	For Each Item In Request.Form
		FormValue = Request.Form(Item)
		If FormValue <> "" Then FormValue = Server.HTMLEncode(FormValue)
    	Response.Write "<tr bgcolor=""#ffffff"">"
		Response.Write "<td>" & Item & "</td>"
		Response.Write "<td>" & FormValue & "&nbsp;</td>"
		Response.Write "</tr>"
	Next
%>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>Session</b></td>
</tr>
<%
	For Each Item In Session.Contents
		SessionValue = Session(Item)
		If SessionValue <> "" Then SessionValue = Server.HTMLEncode(SessionValue)
    	Response.Write "<tr bgcolor=""#ffffff"">"
		Response.Write "<td>" & Item & "</td>"
		Response.Write "<td>" & SessionValue & "&nbsp;</td>"
		Response.Write "</tr>"
	Next
%>
<%
	For Each Item In Request.Cookies
    	   Response.Write "<tr bgcolor=""#ffffff"">"
		   Response.Write "<td>" & Item & "</td>"
		   Response.Write "<td>" & Request.Cookies(Item) & "&nbsp;</td>"
		   Response.Write "</tr>"
	Next
%>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>Cookies</b></td>
</tr>

	
<%For Each strKey In Request.Cookies 
	  Response.Write "<tr bgcolor=""#ffffff"">"
      Response.Write "<td>" & strKey & "</td>"
	  Response.Write "<td>" & Request.Cookies(strKey) & "<td></tr>" 
      If Request.Cookies(strKey).HasKeys Then 
        For Each strSubKey In Request.Cookies(strKey) 
	  Response.Write "<tr bgcolor=""#ffffff""><td>" & "->" & strKey & "(" & strSubKey & ")"
	  Response.Write "<td>" & Request.Cookies(strKey)(strSubKey) & "</td></tr>"
        Next 
      End If 
    Next 
%>
</tr>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>QueryString</b></td>
</tr>
<%
	For Each Item In Request.QueryString
    	   Response.Write "<tr bgcolor=""#ffffff"">"
		   Response.Write "<td>" & Item & "</td>"
		   Response.Write "<td>" & Request.QueryString(Item) & "&nbsp;</td>"
		   Response.Write "</tr>"
	Next
%>
<tr bgcolor="#ff00ff">
	<td colspan="2"><b>ServerVariables</b></td>
</tr>
<%
	For Each Item In Request.ServerVariables
    	   Response.Write "<tr bgcolor=""#ffffff"">"
		   Response.Write "<td>" & Item & "</td>"
		   Response.Write "<td>" & Request.ServerVariables(Item) & "&nbsp;</td>"
		   Response.Write "</tr>"
	Next
%>
</table>
