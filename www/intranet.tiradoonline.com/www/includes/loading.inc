	<!-- <div id="Loading" style="top:100;left:35%;position:absolute;display:none;" class="shadow"> -->
	<div id="Loading" style="position:absolute;display:none;top:35%;left:35%;" class="overlay">
	
		<table cellspacing=0 cellpadding=3 height="100%" border=0 bgcolor="<%= Application("ThemeColor") %>">
		<tr>
			<td>
				<table cellspacing=0 cellpadding=2 border=0 bgcolor=#ffffff>
				<tr>
					<td colspan="2" bgcolor="<%= Application("ThemeColor") %>" align=center>&nbsp;&nbsp;&nbsp;<font color=#ffffff face="Verdana"><b><%= UCase(Application("ApplicationTitle")) %></b></font>&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td align="center">
						<img src="/images/loading.gif" alt="Loading" name="imgLoading" id="imgLoading" width="375" height="108" hspace="0" vspace="0" border="0">
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</div>

