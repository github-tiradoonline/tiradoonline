<!-- 
***********************************************************

LEFT NAVIGATION

***********************************************************
-->

<style>
	#menuTab
	{
		text-shadow: 1px 1px #ffffff;
		border-top-right-radius: 10px;
		border-bottom-right-radius: 10px;
		box-shadow: 3px 3px 4px #000;
		background-color:<%= HEALTH_THEME %>;
		padding:20px;
	}
	
	#menuTab:HOVER
	{
		color: #ffffff;
	}
</style>



<div id="Menu" style="position:fixed">

<table cellpadding="0" cellspacing="2" border="0">
<tr valign="top">
	<td class="shadow">
		<%
			navWidth = "180"
			navHeight = 18
			navStyle = "style=""padding:5px; font-size:12px; border-color:#000000; border-style:solid; border-width:.5px;  vertical-align:middle; width:" & navWidth & "px; opacity:0.6;"""
			navStyle2 = "style=""font-size:8px; color:#fff; padding:5px; vertical-align:middle; width:" & navWidth & "px; text-align:right; opacity:0.6;"""
		%>

 		
		
		
		
		<!-- ******************************************** -->
		<!-- PERSONAL INFO -->
		<!-- ******************************************** -->
		<% If Session("PersonalInformation") OR Session("Administrator") Then %>
		<div id="nav_personal_information" class="PersonalInformationTheme" <%= navStyle %> title="Personal Information">
			<table cellspacing=0 cellpadding=0 border=0 width="100%">
			<tr>
				<td class="PersonalInformationTheme" style="font-size:12px">
					<a href="/personal_information/personal_information.asp?Letter=ALL&Template=View">Personal&nbsp;Information</a>
				</td>
				<td class="PersonalInformationTheme" style="font-size:12px" align="right">
					<a href="/personal_information/personal_information.asp">[&nbsp;Create&nbsp;]</a>&nbsp;&nbsp;
				</td>
			</tr>
			</table>			
		</div>
		<% End If %>
		
		
		
		
		
		<!-- ******************************************** -->
		<!-- BANKING -->
		<!-- ******************************************** -->
		<% If Session("Banking") OR Session("Administrator") Then %>
		<div id="nav_banking" class="BankingTheme" <%= navStyle %> title="Banking">	
			<table cellspacing=0 cellpadding=0 border=0 width="100%">
			<tr>
				<td style="font-size:12px">
					<img src="/images/icons/plus_black.gif" id="bankingAccordion" name="bankingAccordion" title="" width="15" height="10" hspace="0" vspace="0" border="0">
					<a href="/banking/banking.asp">Banking</a>
				</td>
				<td align="right" style="font-size:12px">
					<a href="/banking/banking.asp?Template=Search">[&nbsp;Search&nbsp;]</a>&nbsp;&nbsp;
				</td>
			</tr>
			</table>
		</div>

		<div id="bankingSubMenu" name="bankingSubMenu" style="display:none">
		<%
				sql = "sp_BankingAccount_get " & Session("UserID")
				WriteDebugger sql, Debugging, 0
				Set ors = oConn.Execute(sql)
				TotalBanking = 0.00

				If NOT ors.EOF OR Session("Administrator") Then
					Do Until ors.EOF
						BankingAccountID = ors("BankingAccountID")
						BankingAccountName = ors("BankingAccountName")
						TotalBanking = ors("TotalBanking")
						ReceiveEmails = ors("ReceiveEmails")
						If ReceiveEmails Then 
							ReceiveEmails = EMAIL_ICON
						Else
							ReceiveEmails = ""
						End If 
			%>
			<!-- ******************************************** -->
			<!-- BANKING SUB NAV -->
			<!-- ******************************************** -->
			<div class="BankingSubElement" <%= navStyle2 %> title="<%= BankingAccountName %>">
				<%= ReceiveEmails %><a href="/banking/banking.asp?BankingAccountID=<%= ors("BankingAccountID") %>&CurrentDate=<%= CurrentDate %>&Template=View" <%= navStyle2 %>><%= BankingAccountName %></a>&nbsp;&nbsp;<%= ProfitLoss2(TotalBanking) %><br />
				<nobr>
				<a href="/banking/banking.asp?Template=BankingAccount&BankingAccountID=<%= ors("BankingAccountID") %>&CurrentDate=<%= CurrentDate %>" <%= navStyle2 %>>[Edit Account]</a>&nbsp;
				<a href="/banking/banking.asp?BankingAccountID=<%= ors("BankingAccountID") %>&CurrentDate=<%= CurrentDate %>&Template=Add" <%= navStyle2 %>>[Add Transaction]</a></nobr>
			</div>
		<%
						ors.MoveNext
					Loop
					ors.Close
				End If
				Set ors = Nothing
		%>
		</div>

		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- HEALTH -->
		<!-- ******************************************** -->
		<% If Session("Health") OR Session("Administrator") Then %>
		<div id="nav_health" class="HealthTheme" <%= navStyle %> title="Health">
			<a href="/health/health.asp">Health</a>
		</div>
		<% End If %>
		





		<!-- ******************************************** -->
		<!-- CALENDAR -->
		<!-- ******************************************** -->
		<div id="nav_calendar" class="CalendarTheme" <%= navStyle %> title="Calendar">
			<a href="/calendar/calendar.asp">Calendar</a>
		</div>
		
		
		
		

		
		
		
		
		<!-- ******************************************** -->
		<!-- TIMESHEET -->
		<!-- ******************************************** -->
		<% If Session("Timesheet") OR Session("Administrator") Then %>
		<div id="nav_timesheet" class="TimesheetTheme" <%= navStyle %> title="Timesheet">
			<a href="/timesheet/timesheet.asp?template=company">Timesheet</a>
		</div>
		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- JOBS -->
		<!-- ******************************************** -->
		<% If Session("Jobs") OR Session("Administrator") Then %>
		<div id="nav_jobs" class="JobsTheme" <%= navStyle %> title="Jobs">
			<a href="/jobs/jobs.asp">Jobs</a>
		</div>
		<% End If %>
		
		
		
		
		
		<!-- ******************************************** -->
		<!-- UPLOADS -->
		<!-- ******************************************** -->
		<div id="nav_uploads" class="UploadsTheme" <%= navStyle %> title="Uploads">
			<a href="/uploads/uploads.asp">Uploads</a>
		</div>
		
		
		
		
		
		<!-- ******************************************** -->
		<!-- MEDIA -->
		<!-- ******************************************** -->
		<div id="nav_media" class="SnippetsTheme" <%= navStyle %> title="Media">
			<a href="/media/media.asp">Media</a>
		</div>
		





		<!-- ******************************************** -->
		<!-- PHONEBILL -->
		<!-- ******************************************** -->
		<div id="nav_phonebill" class="PhoneBillTheme" <%= navStyle %> title="PhoneBill">
			<a href="/phonebill/phonebill.asp">Phone&nbsp;Bill</a>
		</div>
		<!-- ******************************************** -->
		<!-- EMAIL -->
		<!-- ******************************************** -->
		<div id="nav_email" class="EmailTheme" <%= navStyle %> title="Email">
			<a href="/email/email.asp">Email</a>
		</div>




		<!-- ******************************************** -->
		<!-- REMINDERS -->
		<!-- ******************************************** -->
		<div id="nav_reminders" class="RemindersTheme" <%= navStyle %> title="reminders">
			<a href="/reminders/reminders.asp">Reminders</a>
		</div>




		<!-- ******************************************** -->
		<!-- ADMINISTRATION -->
		<!-- ******************************************** -->
		<% If Session("Administrator") Then %>
		<div id="nav_administration" class="AdministrationTheme" <%= navStyle %> title="Control Panel">
			<a href="/administration/administration.asp">Control&nbsp;Panel</a>
		</div>
		<% End If %>




		<!-- ******************************************** -->
		<!-- FACEBOOK -->
		<!-- ******************************************** -->
<!-- 		<% If Session("Facebook") = true OR Session("Administrator") Then %>
		<div id="nav_facebook" class="FacebookTheme" <%= navStyle %> title="Facebook">
			<a href="/facebook/facebook.asp">Facebook</a>
		</div>
		<% End If %>
 -->


		<!-- ******************************************** -->
		<!-- CONTACTS -->
		<!-- ******************************************** -->
<!-- 		<% If Session("Contacts") OR Session("Administrator") Then %>
		<div id="nav_contacts" class="ContactsTheme" <%= navStyle %> title="Contacts">
			<a href="/contacts/contacts.asp?Template=View&Letter=">Contacts</a>
		</div>
		<% End If %>
 -->		
		
		
		
		<!-- ******************************************** -->
		<!-- CREDIT CARDS -->
		<!-- ******************************************** -->
		<% If Session("CreditCards") OR Session("Administrator") Then %>
		<div id="nav_creditcards" class="CreditCardsTheme" <%= navStyle %> title="Credit Cards">
			<a href="/creditcards/creditcards.asp?Template=CreditCards">Credit&nbsp;Cards</a>
		</div>
		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- MONTHLY EXPENSES -->
		<!-- ******************************************** -->
		<% If Session("MonthlyExpenses") OR Session("Administrator") Then %>
		<div id="nav_monthly_expenses" class="BankingMonthlyExpensesTheme" <%= navStyle %> title="Monthly Expenses">
			<a href="/monthly_expenses/monthly_expenses.asp?Template=MonthlyExpenses">Monthly&nbsp;Expenses</a>
		</div>
		<% End If %>
		
		
		
		<!-- ******************************************** -->
		<!-- COLLECTION AGENCIES -->
		<!-- ******************************************** -->
		<% If Session("CollectionAgency") OR Session("Administrator") Then %>
		<div id="nav_collection_agency" class="CollectionAgencyTheme" <%= navStyle %> title="Collection Agency">
			<a href="/collection_agency/collection_agency.asp?Template=Collection">Collection&nbsp;Agency</a>
		</div>
		<% End If %>
		
		
		
		
		
		<!-- ******************************************** -->
		<!-- SNIPPETS -->
		<!-- ******************************************** -->
		<% If Session("Snippets") OR Session("Administrator") Then %>
		<div id="nav_snippets" class="SnippetsTheme" <%= navStyle %> title="Snippets">
			<a href="/snippets/snippets.asp">Snippets</a>
		</div>
		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- METROCARD -->
		<!-- ******************************************** -->
		<!-- 
		<% If Session("MetroCard") OR Session("Administrator") Then %>
		<div id="nav_recovery" class="MetroCardTheme" <%= navStyle %> title="MetroCard">
			<a href="/metrocard/metrocard.asp">MetroCard</a>
		</div>
		<% End If %>
		 -->
		
		
		
		<!-- ******************************************** -->
		<!-- RECOVERY -->
		<!-- ******************************************** -->
		<% If Session("Recovery") OR Session("Administrator") Then %>
		<div id="nav_recovery" class="RecoveryTheme" <%= navStyle %> title="Recovery">
			<a href="/recovery/recovery.asp">Recovery</a>
		</div>
		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- SERVER INFORMATION -->
		<!-- ******************************************** -->
		<% If Session("Servers") OR Session("Administrator") Then %>
		<div id="nav_servers" class="ServerTheme" <%= navStyle %> title="Servers">
			<a href="/servers/servers.asp">Servers</a>
		</div>
		<% End If %>
		
		
		
		
		<!-- ******************************************** -->
		<!-- TIRADOONLINE.COM -->
		<!-- ******************************************** -->
		<% If Session("tiradoonline") OR Session("Administrator") Then %>
		<div id="nav_tiradoonline" class="tiradoonlineTheme" <%= navStyle %> title="tiradoonline.com">
			<a href="/tiradoonline/tiradoonline.asp">tiradoonline.com</a>
		</div>
		<% End If %>
		
		
		
		<!-- ******************************************** -->
		<!-- SETTINGS -->
		<!-- ******************************************** -->
		<div id="nav_settings" class="SettingsTheme" <%= navStyle %> title="Settings">
			<a href="/settings/settings.asp?template=settings">Settings</a>
		</div>
		
		
		
		
		<!-- ******************************************** -->
		<!-- PROFILE -->
		<!-- ******************************************** -->
		<div id="nav_profile" title="Profile" class="HomeTheme" <%= navStyle %>>
			<a href="/home.asp">Profile</a>
		</div>
		
		
		
		
		<!-- ******************************************** -->
		<!-- LOGOUT -->
		<!-- ******************************************** -->
		<div id="nav_logout" class="LogoutTheme" <%= navStyle %> title="Logout">
			<a href="javascript:void(null)" onclick="logoutClick()">Logout</a>
		</div>
	</td>
	<td valign="top">
 		<div id="menuTab" name="menuTab" title="M E N U">
		 	M<br />
 			E<br />
			N<br />
			U
 		</div>
 	</td>
</tr>
</table>
<div id="subnav_administration" class="subnav">
	<!-- #include virtual="/administration/templates/home.tem" -->
</div>
<% BankingImageID = "nav" %>
<div id="subnav_banking" class="subnav">
	<!-- #include virtual="/banking/templates/home.tem" -->
</div>
<% CreditCardImageID = "nav" %>
<div id="subnav_health" class="subnav">
	<!-- #include virtual="/health/templates/home.tem" -->
</div>
<div id="subnav_creditcards" class="subnav">
	<!-- #include virtual="/creditcards/templates/home.tem" -->
</div>
<div id="subnav_monthly_expenses" class="subnav">
	<!-- #include virtual="/monthly_expenses/templates/home.tem" -->
</div>
<div id="subnav_collection_agency" class="subnav">
	<!-- #include virtual="/collection_agency/templates/home.tem" -->
</div>
<div id="subnav_jobs" class="subnav">
	<!-- #include virtual="/jobs/templates/home.tem" -->
</div>
<div id="subnav_recovery" class="subnav">
	<!-- #include virtual="/recovery/templates/home.tem" -->
</div>
<div id="subnav_servers" class="subnav">
	<!-- #include virtual="/servers/templates/home.tem" -->
</div>
<div id="subnav_timesheet" class="subnav">
	<!-- #include virtual="/timesheet/templates/home.tem" -->
</div>
<div id="subnav_tiradoonline" class="subnav">
	<!-- #include virtual="/tiradoonline/templates/home.tem" -->
</div>

<script type="text/javascript">
<%
	'*****************
	' IF ADDED UPDATE function.inc SubNavigation()
	'*****************

	sub_nav_hide = ""
	sub_nav_hide = sub_nav_hide & "$('#subnav_administration').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_banking').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_health').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_monthly_expenses').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_collection_agency').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_creditcards').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_jobs').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_recovery').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_servers').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_timesheet').hide();" & vbCrLF
	sub_nav_hide = sub_nav_hide & "$('#subnav_tiradoonline').hide();" & vbCrLF
%>
		// CALENDAR
        $('#nav_calender').mouseenter(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);

		// REMINDERS
        $('#nav_reminders').mouseenter(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);
		
		// ADMINISTRATION		
        $('#nav_administration').mouseenter(
			function(evt) 
			{
				$('#subnav_administration').css("left", $(this).css("width"));
				$('#subnav_administration').css("top", evt.pageY - 30);
				$('#subnav_administration').show();
				<%= SubNavigation("administration") %>
			}	
		);

		$('#subnav_administration').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// BANKING
        $('#nav_banking').mouseenter(
			function(evt) 
			{
				$('#subnav_banking').css("left", $(this).css("width"));
				$('#subnav_banking').css("top", evt.pageY - 30);
				$('#subnav_banking').show();
				<%= SubNavigation("banking") %>
			}
		);

		$('#subnav_banking').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// PERSONAL INFORMATION
        $('#nav_personal_information').mouseenter(
			function(evt) 
			{
				<%= sub_nav_hide %>
			}
		);

		// HEALTH
        $('#nav_health').mouseenter(
			function(evt) 
			{
				$('#subnav_health').css("left", $(this).css("width"));
				$('#subnav_health').css("top", evt.pageY - 30);
				$('#subnav_health').show();
				<%= SubNavigation("health") %>
			}
		);

		$('#subnav_health').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// CREDIT CARDS
        $('#nav_creditcards').mouseenter(
			function(evt) 
			{
				$('#subnav_creditcards').css("left", $(this).css("width"));
				$('#subnav_creditcards').css("top", evt.pageY - 30);
				$('#subnav_creditcards').show();
				<%= SubNavigation("creditcards") %>
			}
		);

		$('#subnav_creditcards').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// MONTHLY EXPENSES
        $('#nav_monthly_expenses').mouseenter(
			function(evt) 
			{
				$('#subnav_monthly_expenses').css("left", $(this).css("width"));
				$('#subnav_monthly_expenses').css("top", evt.pageY - 30);
				$('#subnav_monthly_expenses').show();
				<%= SubNavigation("monthly_expenses") %>
			}
		);
        $('#subnav_monthly_expenses').mouseleave(
			function(evt) 
			{
				$(this).hide();
			}
		);

		// COLLECTION AGENCY
        $('#nav_collection_agency').mouseenter(
			function(evt) 
			{
				$('#subnav_collection_agency').css("left", $(this).css("width"));
				$('#subnav_collection_agency').css("top", evt.pageY - 30);
				$('#subnav_collection_agency').show();
				<%= SubNavigation("collection_agency") %>
			}
		);
        $('#subnav_collection_agency').mouseleave(
			function(evt) 
			{
				$(this).hide();
}
		);

		// SNIPPETS
        $('#nav_snippets').mouseenter(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);
        $('#nav_snippets').mouseleave(
			function(evt) 
			{
				<%= SubNavigation("") %>
}
		);

		// JOBS
        $('#nav_jobs').mouseenter(
			function(evt) 
			{
				$('#subnav_jobs').css("left", $(this).css("width"));
				$('#subnav_jobs').css("top", evt.pageY - 30);
				$('#subnav_jobs').show();
				<%= SubNavigation("jobs") %>
			}
		);

		$('#subnav_jobs').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// RECOVERY
        $('#nav_recovery').mouseenter(
			function(evt) 
			{
				$('#subnav_recovery').css("left", $(this).css("width"));
				$('#subnav_recovery').css("top", evt.pageY - 30);
				$('#subnav_recovery').show();
				<%= SubNavigation("recovery") %>
			}
		);

		$('#subnav_recovery').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// SERVER INFORMATION
        $('#nav_servers').mouseenter(
			function(evt) 
			{
				$('#subnav_servers').css("left", $(this).css("width"));
				$('#subnav_servers').css("top", evt.pageY - 30);
				$('#subnav_servers').show();
				<%= SubNavigation("servers") %>
			}
		);
        $('#nav_servers').mouseleave(
			function(evt) 
			{
				<%= SubNavigation("servers") %>
			}
		);

		$('#subnav_servers').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// TIMESHEETS
        $('#nav_timesheet').mouseenter(
			function(evt) 
			{
				$('#subnav_timesheet').css("left", $(this).css("width"));
				$('#subnav_timesheet').css("top", evt.pageY - 30);
				$('#subnav_timesheet').show();
				<%= SubNavigation("timesheet") %>
			}
		);

		$('#subnav_timesheet').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// TIRADOONLINE
        $('#nav_tiradoonline').mouseenter(
			function(evt) 
			{
				$('#subnav_tiradoonline').css("left", $(this).css("width"));
				$('#subnav_tiradoonline').css("top", evt.pageY - 30);
				$('#subnav_tiradoonline').show();
				<%= SubNavigation("tiradoonline") %>
			}
		);

		$('#subnav_tiradoonline').mouseleave(
			function() 
			{
				$(this).hide();
			}
		);

		// SETTINGS
        $('#nav_settings').mouseenter(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);
        $('#nav_settings').mouseleave(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);

		// PROFILE
        $('#nav_profile').mouseenter(
			function(evt) 
			{
				<%= SubNavigation("") %>
			}
		);
        $('#nav_profile').mouseleave(
			function(evt) 
			{
				<%= sub_nav_hide %>
			}
		);

		// LOGOUT
        $('#nav_logout').mouseenter(
			function(evt) 
			{
				<%= sub_nav_hide %>
			}
		);
        $('#nav_logout').mouseleave(
			function(evt) 
			{
				<%= sub_nav_hide %>
			}
		);

</script>


<!-- 
**********************************************************

END OF LEFT NAVIGATION

***********************************************************
 -->

</div>
<script type="text/javascript">
	var $navwidth = 0;
	var $navPosition = getCookie("navPosition");
	
	if($navPosition == null || $navPosition == '')
	{
		$navPosition = -<%= navWidth %> - 15;
		setCookie("navPosition", $navPosition, 10);
	}
	
	$('#navigationMenu').css('left', $navPosition);
	
	$('#menuTab').toggle(
		function() 
		{
			if($navPosition == 0)
				$navPosition = -<%= navWidth %> - 15;
			else
				$navPosition = 0;

			$('#navigationMenu').animate({left: $navPosition});
			setCookie("navPosition", $navPosition, 10);
		},
		function() 
		{
			if($navPosition == 0)
				$navPosition = -<%= navWidth %> - 15;
			else
				$navPosition = 0;

			$('#navigationMenu').animate({left: $navPosition});
			setCookie("navPosition", $navPosition, 10);
		}
	);

	$('#NavigationTable tr').hover
	(
		function()
		{
			var thisTR = $(this).attr('id');
			$('#' + thisTR).css('border-color', '#ff00ff');
		},
		function()
		{
			var thisTR = $(this).attr('id');
			$('#' + thisTR).css('border-color', '#ff00ff');
		}
	);

	
	var $bankingAccordion = getCookie("bankingAccordion");
	if($bankingAccordion == null || $bankingAccordion == '')
	{
		$bankingAccordion = 0;
		setCookie("bankingAccordion", $bankingAccordion, 10);
	}
		
	if($bankingAccordion == 1)
	{
		$('#bankingAccordion').attr('src', '/images/icons/minus_black.gif');
		$('#bankingSubMenu').show();
	}
	
	$('#bankingAccordion').toggle
	(
		function ()
		{
			if($bankingAccordion == 0)
			{
				$(this).attr('src', '/images/icons/minus_black.gif');
				$('#bankingSubMenu').slideDown(1000);
				$bankingAccordion = 1;
			}
			else
			{
				$(this).attr('src', '/images/icons/plus_black.gif');
				$('#bankingSubMenu').slideUp(1000);
				$bankingAccordion = 0;
			}

			setCookie("bankingAccordion", $bankingAccordion, 10);
		},
		function ()
		{
			if($bankingAccordion == 0)
			{
				$(this).attr('src', '/images/icons/minus_black.gif');
				$('#bankingSubMenu').slideDown(1000);
				$bankingAccordion = 1;
			}
			else
			{
				$(this).attr('src', '/images/icons/plus_black.gif');
				$('#bankingSubMenu').slideUp(1000);
				$bankingAccordion = 0;
			}

			setCookie("bankingAccordion", $bankingAccordion, 10);
		}
	);

</script>
