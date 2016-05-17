

					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>

	</div>
		</td>
	</tr>
	</table>

</div>

<script language="JavaScript">
<!--
	function Logout()
	{
		alert("Your session has timed out");
		redirectURL = "/default.asp?SubmitButton=Logout"
		location.href = redirectURL;
		
	}
	
	setTimeout("Logout()", <%= Session.Timeout * 60000 %>);
	
//-->
</script>

<!-- #include virtual="/includes/modals/spinner.inc" -->

<% If Debugging Then %>
<br clear="all">
<!-- #include virtual="/includes/debug.inc" -->
<% End If %>

<% If Session("RemindersAlert") = "" Then %>
<%
	ReminderDays = 30
	sql = "sp_Reminders_alert " & Session("UserID") & ", " & ReminderDays 
	Set ors = oConn.Execute(sql)
	
	If NOT ors.EOF Then
%>
<div style="z-index:5; position:absolute; left:0px; top:0px; padding:5px;" id="RemindersAlert" name="RemindersAlert">

	<table width="100%" cellspacing="0" cellpadding"0" border="0" style="padding:5px">
	<tr>
		<td class="RemindersTheme" style="font-size:15px; font-weight:bold; color:#fff;">
			&nbsp;&nbsp;&nbsp;<a href="/reminders/reminders.asp">Reminders for upcoming <%= ReminderDays %> Days</a>
		</td>
		<td class="RemindersTheme" valign="middle" align="right">
			<%= X_ICON %>
		</td>
	</tr>
	</table>
	
	<!-- #include virtual="/reminders/includes/grid.inc" -->
	
</div>
<% 
	End If 
	Set ors = Nothing
%>

<script type="text/javascript">
	
	$('#X_ICON').click
	(
		function()
		{
			$('#RemindersAlert').hide();
		}
	);

</script>

<%
	Session("RemindersAlert") = "1"
	End If
%>
</body>
</html>
