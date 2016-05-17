<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/functions.inc" -->

<%
	txt_sql = Trim(Request("txt_sql"))
	Response.Write txt_sql
%>



<style type="text/css">
	.txt_sql
	{
		background-color: #000;
		color: #fff;
		width: 100%;
		height: 100px;
	}
</style>

<form method="post">
<table width="100%">
<tr>
	<td align="right">
		<input type="submit" id="SubmitButton" name="SubmitButton" value="Execute Query" />
	</td>
</tr>
<tr>
	<td>
		<textarea id="txt_sql" name="txt_sql" class="txt_sql"><%= txt_sql %></textarea>
	</td>
</tr>
</table>
<%
 	If SubmitButton = "Execute Query" Then
		Set rs = oConn.Execute(txt_sql)
		If NOT rs.EOF Then
%>
<tr>
	<td>
		<textarea id="txt_sql" name="txt_sql" class="txt_sql"><%= ConvertToJSON(rs, "SQL") %></textarea>
	</td>
</tr>
<%
			Response.End
			rs.MoveFirst
			TotalRows = SQLTotalRows(rs)
			TotalColumns = 0
			For Each Item in rs.Fields
				TotalColumns = TotalColumns + 1
			Next
			
			Response.Write "<table cellspacig=""1"" cellpadding=""2"" border=""0"" bgcolor='#000000'>" & vbCrLF
			Response.Write "<tr align='center'>" & vbCrLF
			Response.Write "	<td colspan='" & TotalColumns & "' bgcolor='#dddddd'><b>Total&nbsp;Rows:&nbsp;" & TotalRows & "</b>&nbsp;</td>"
			Response.Write "<tr>" & vbCrLF
			Response.Write "<tr align='center'>" & vbCrLF
			For Each Item in rs.Fields
				Response.Write "	<td bgcolor='#dddddd'>" & Item.Name & "&nbsp;</td>"
			Next
			Response.Write "</tr>" & vbCrLF
			Do Until rs.EOF
				Response.Write "<tr align='center'>" & vbCrLF
				For Each Item in rs.Fields
					'On Error Resume Next
					Response.Write "	<td bgcolor='#ffffff'><font face=""Verdana,Arial"" size=1>" & Item.Value & "&nbsp;</td>"
					'If Err.Number <> 0 Then Response.Write "	<td>&nbsp;</td>"
					'Err.Clear
				Next
				Response.Write "</tr>" & vbCrLF
				rs.MoveNext
			Loop
			Response.Write "</table>" & vbCrLF
			rs.Close
		Else
			Response.Write "No records returned."
		End If
		Set rs = Nothing
	End If
%>
</form>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
