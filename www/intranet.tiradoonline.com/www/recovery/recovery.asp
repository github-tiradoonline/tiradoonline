<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "recoveryTheme"
	PageThemeColor = RECOVERY_THEME
	PageTitle = "Recovery"
	HeaderTitle = "Recovery"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->
<%
	'*** RECOVERY PROGRAMS
	RecoveryProgramID = Trim(Request("RecoveryProgramID"))
	RecoveryTypeID = Trim(Request("RecoveryTypeID"))
	ProgramName = Trim(Request("ProgramName"))
	start_dt = Trim(Request("start_dt"))	
	end_dt = Trim(Request("end_dt"))
	sober_dt = Trim(Request("sober_dt"))
	
	'*** RECOVERY COUNSELORS	
	RecoveryCounselorID = Trim(Request("RecoveryCounselorID"))
	FirstName = Trim(Request("FirstName"))
	LastName = Trim(Request("LastName"))
	
	'*** RECOVERY GROUPS
	RecoveryGroupID = Trim(Request("RecoveryGroupID"))
	RecoveryGroupName = Trim(Request("RecoveryGroupName"))
	
	'*** RECOVERY GROUP SESSIONS
	RecoveryGroupSessionID = Trim(Request("RecoveryGroupSessionID"))
	RecoveryGroupSessionDate = Trim(Request("RecoveryGroupSessionDate"))
	If RecoveryGroupSessionDate = "" Then RecoveryGroupSessionDate = FormatDateTime(Now, 2)
	RecoveryGroupSessionTime = Trim(Request("RecoveryGroupSessionTime"))
	RecoveryGroupSessionDateTime = Trim(RecoveryGroupSessionDate & " " & RecoveryGroupSessionTime)
	ScheduledGroup = Trim(Request("ScheduledGroup"))
	If ScheduledGroup = "" Then ScheduledGroup = "0"
	'ScheduledGroup = CBool(ScheduledGroup)
	Comments = Trim(Request("Comments"))
	RecoveryGroupSessionDatePickerStartDate = Trim(Request("RecoveryGroupSessionDatePickerStartDate"))
	RecoveryGroupSessionDatePickerEndDate = Trim(Request("RecoveryGroupSessionDatePickerEndDate"))
	If RecoveryGroupSessionDatePickerEndDate = "" Then RecoveryGroupSessionDatePickerEndDate = Date

	'*** RECOVERY Drug Test
	RecoveryDrugTestID = Trim(Request("RecoveryDrugTestID"))
	RecoveryDrugTestTypeID = Trim(Request("RecoveryDrugTestTypeID"))
	RecoveryDrugTestDateTime = Trim(Request("RecoveryDrugTestDateTime"))
	RecoveryDrugTestResult = Trim(Request("RecoveryDrugTestResult"))
	If RecoveryDrugTest = "" Then RecoveryDrugTest = "0"
	RecoveryDrugTestDescription = Trim(Request("RecoveryDrugTestDescription"))
	
	'*** AA
	RecoveryType = Trim(Request("RecoveryType"))
	AA_MeetingBoroughID = Trim(Request("AA_MeetingBoroughID"))
	AA_MeetingBoroughName = Trim(Request("AA_MeetingBoroughName"))

	AA_MeetingTypeID = Trim(Request("AA_MeetingTypeID"))
	AA_MeetingTypeAbbr = Trim(Request("AA_MeetingTypeAbbr"))
	AA_MeetingTypeName = Trim(Request("AA_MeetingTypeName"))
	
	AA_MeetingTimeTypeID = Trim(Request("AA_MeetingTimeTypeID"))
	AA_MeetingTimeTypeAbbr = Trim(Request("AA_MeetingTimeTypeAbbr"))
	AA_MeetingTimeTypeName = Trim(Request("AA_MeetingTimeTypeName"))

	AA_MeetingDayOfWeekID = Trim(Request("AA_MeetingDayOfWeekID"))
	AA_MeetingDayOfWeekName = Trim(Request("AA_MeetingDayOfWeekName"))

	AA_MeetingLocationID = Trim(Request("AA_MeetingLocationID"))
	AA_MeetingBoroughID = Trim(Request("AA_MeetingBoroughID"))
	AA_MeetingTypeID = Trim(Request("AA_MeetingTypeID"))
	AA_MeetingTimeTypeID = Trim(Request("AA_MeetingTimeTypeID"))
	AA_Zone = Trim(Request("AA_Zone"))
	AA_MeetingName = Trim(Request("AA_MeetingName"))
	AA_Address1 = Trim(Request("AA_Address1"))
	AA_Address2 = Trim(Request("AA_Address2"))
	AA_Address3 = Trim(Request("AA_Address3"))
	AA_ZipCode = Trim(Request("AA_ZipCode"))
	AA_Comments = Trim(Request("AA_Comments"))
	
%>
<!-- #include virtual="/includes/open_header.inc" -->

				<% If LCase(Template) = "aa" Then %>
				<!-- #include file="templates/aa.tem" -->
				<% ElseIf LCase(Template) = "recovery_types" Then %>
				<!-- #include file="templates/recovery_types.tem" -->
				<% ElseIf LCase(Template) = "recovery_programs" Then %>
				<!-- #include file="templates/recovery_programs.tem" -->
				<% ElseIf LCase(Template) = "recovery_counselors" Then %>
				<!-- #include file="templates/recovery_counselors.tem" -->
				<% ElseIf LCase(Template) = "recovery_groups" Then %>
					<!-- #include file="templates/recovery_groups.tem" -->
				<% ElseIf LCase(Template) = "recovery_group_sessions" Then %>
					<!-- #include file="templates/recovery_group_sessions.tem" -->
				<% ElseIf LCase(Template) = "recovery_drugtest" Then %>
					<!-- #include file="templates/recovery_drugtest.tem" -->
				<% ElseIf Template = "" Then %>
				<!-- #include file="templates/home.tem" -->
				<% End If %>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
