<nav class="navbar navbar-inverse navbar-fixed-top">

	<div class="container-fluid">

	    <!-- Brand and toggle get grouped for better mobile display -->
    	<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        	<span class="sr-only">Toggle navigation</span>
    	    	<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
      		</button>
      		<a class="navbar-brand" href="/home.asp">tiradoonline.com</a>
    	</div>

    	
		<div class="collapse navbar-collapse navbar-responseive-collapse" id="bs-example-navbar-collapse-1">

			<!-- FINANCIAL -->
			<ul class="nav navbar-nav">
				<li class="dropdown <% If InStr(SCRIPT_NAME, "banking.asp") > 0 OR InStr(SCRIPT_NAME, "creditcards.asp") > 0 OR InStr(SCRIPT_NAME, "monthly_expenses.asp") > 0 OR InStr(SCRIPT_NAME, "collection_agency.asp") > 0 Then Response.Write " active " %>">
					 <a class="dropdown-toggle" data-toggle="dropdown" href="#">Financial <strong class="caret"></strong></a>
				
					<ul class="dropdown-menu">
						<li><a href="/banking/banking.asp">Banking</a></li>
						<li><a href="/creditcards/creditcards.asp">Credit Cards</a></li>
						<li><a href="/monthly_expenses/monthly_expenses.asp">Monthly Expenses</a></li>
						<li><a href="/collection_agency/collection_agency.asp">Collection Agencies</a></li>
					</ul>
					<!-- end dropdown-menu -->
				</li>
			</ul>
			<!-- end financial -->			

			<!-- personal information -->
			<ul class="nav navbar-nav">
				<li<% If InStr(SCRIPT_NAME, "personal_information.asp") > 0 Then Response.Write " class=""active""" %>>
					<a href="/personal_information/personal_information.asp">Personal&nbsp;Information</a>
				</li>
			</ul>
			<!-- end personal information -->
	
			<!-- OUTLOOK -->
			<ul class="nav navbar-nav">
				<li class="dropdown<% If InStr(SCRIPT_NAME, "email.asp") > 0 Then Response.Write " active" %>">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Outlook <span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<li>
							<a href="/email/email.asp">Email</a>
						</li>
						<li>
							<a href="/calendar/calendar.asp">Calendar</a>
						</li>
						<li>
							<a href="/reminders/reminders.asp">Reminders</a>
						</li>
					</ul>
					<!-- end dropdown-menu -->
				</li>
			</ul>
			<!-- end OUTLOOK -->
	
			<!-- EMPLOYMENT -->
			<ul class="nav navbar-nav">
				<li class="dropdown<% If InStr(SCRIPT_NAME, "jobs.asp") > 0 OR InStr(SCRIPT_NAME, "timesheet.asp") > 0 Then Response.Write " active" %>">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Employment <span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<li><a href="/jobs/jobs.asp">Jobs</a></li>
						<li><a href="/timesheet/timesheet.asp">Timesheet</a></li>
					</ul>
					<!-- end dropdown-menu -->
	
				</li>
				<!-- end dropdown -->
			</ul>
			<!-- end EMPLOYMENT -->
				
			<!-- HEALTH -->
			<ul class="nav navbar-nav">
				<li class="dropdown<% If InStr(SCRIPT_NAME, "health.asp") > 0 Then Response.Write " class=""active""" %>">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Health <span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<li><a href="/health/health.asp?Template=all">All</a></li>
						<li><a href="/health/health.asp?Template=sugar">Sugar</a></li>
						<li><a href="/health/health.asp?Template=heart_rate">Heart&nbsp;Rate</a></li>
						<li><a href="/health/health.asp?Template=temperature">Temperature</a></li>
						<li><a href="/health/health.asp?Template=tests">Tests</a></li>
	
						<li class="dropdown">
	
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Medicine <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="/health/health.asp?Template=medicine">Medicine</a></li>
								<li><a href="/health/health.asp?Template=medicine_dose">Medicine&nbsp;Dose</a></li>
								<li><a href="/health/health.asp?Template=medicine_dose_package">Medicine&nbsp;Dose&nbsp;Package</a></li>
								<li><a href="/health/health.asp?Template=medicinerefill">Medicine Refills</a></li>
							</ul>
							
						</li>
	
						<li><a href="/health/health.asp?Template=sugar_report">Sugar&nbsp;Report</a></li>
						<li><a href="/health/health.asp?Template=blood_pressure">Blood&nbsp;Pressure</a></li>
						<li><a href="/health/health.asp?Template=unit">Units</a></li>
						<li><a href="/health/health.asp?Template=weight">Weight</a></li>
						<li><a href="/health/health.asp?Template=reports">Reports</a></li>
						<li><a href="/health/health.asp?Template=doctor">Doctors</a></li>
						<li><a href="/health/health.asp?Template=pharmacy">Pharmacy</a></li>
						<li><a href="/health/health.asp?Template=export">Export</a></li>
						<li><a href="/health/health.asp?Template=hospital">Hospitals</a></li>
						<li><a href="/health/health.asp?Template=hospitalposition">Hospital&nbsp;Positions</a></li>
						<li><a href="/health/health.asp?Template=hospitalstaff">Hospital&nbsp;Staff</a></li>
						<li><a href="/health/health.asp?Template=medicine_last_100">Last&nbsp;100&nbsp;Transactions</a></li>
					</ul>
					<!-- end dropdown-menu -->
	
				</li>
			</ul>
			<!-- end HEALTH -->
			
			<!-- SNIPPETS -->
	      	<ul class="nav navbar-nav">
				<li<% If InStr(SCRIPT_NAME, "snippets.asp") > 0 Then Response.Write " class=""active""" %>>
					<a href="/snippets/snippets.asp">Snippets</a>
				</li>
			</ul>
			<!-- end of SNIPPETS -->
	
			<!-- RECOVERY -->
	    	<ul class="nav navbar-nav">
				<li>
					<a href="/recovery/recover.asp">Recovery</a></a>
				</li>
			</ul>
			<!-- end of RECOVERY -->
	
	
			<!-- TIRADOONLINE.COM -->
	      		<ul class="nav navbar-nav">
				<li>
					<a href="/tiradoonline/tiradoonline.asp">tiradoonline.com <span class="caret"></span></a>
				</li>
			</ul>
			<!-- end of SNIPPETS -->
			
				
			<!-- SETTINGS -->
	   		<ul class="nav navbar-nav">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings <span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<li><a href="/home.asp">Profile</a></li>
						<li><a href="/administration/administration.asp">Control&nbsp;Panel</a></li>
						<li><a href="/servers/servers.asp">Servers</a></li>
					</ul>
					<!-- end dropdown-menu -->
		
				</li>
				<!-- end dropdown -->
	    	</ul>
			<!-- end of SETTINGS-->
    
		</div><!-- /.navbar-collapse -->
  
  </div><!-- /.container-fluid -->

</nav>