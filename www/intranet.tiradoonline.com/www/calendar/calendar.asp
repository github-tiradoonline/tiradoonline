<!-- #include virtual="/includes/globals.inc" -->
<!-- #include virtual="/includes/open_connection.inc" -->
<%
	PageTheme = "CalendarTheme"
	PageThemeColor = CALENDAR_THEME
	PageTitle = "Calendar"
	HeaderTitle = "Calendar"
	Response.Buffer = true
%>
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	Response.Buffer = true
	Session("Navigation") = "calendar"
	Template = Trim(Request("Template"))

	CurrentMonth = Trim(Request("CurrentMonth"))
	CurrentYear = Trim(Request("CurrentYear"))
	If CurrentMonth = "" Then
		CurrentMonth = Month(Date)
		CurrentYear = Year(Date)
	Else
		CurrentMonth = CInt(CurrentMonth)
		CurrentYear = CInt(CurrentYear)
	End If
	If CurrentMonth = 12 Then 
		NextMonth = 1
		NextYear = CurrentYear + 1
	Else
		NextMonth = CurrentMonth + 1
		NextYear = CurrentYear
	End If
	If CurrentMonth = 1 Then 
		PreviousMonth = 12
		PreviousYear = CurrentYear - 1
	Else
		PreviousMonth = CurrentMonth - 1
		PreviousYear = CurrentYear
	End If
%>


<!-- #include virtual="/includes/open_header.inc" -->


<!-- #include virtual="/calendar/includes/legend.inc" -->

<% If Template = "" Then %>
	<!-- #include file="templates/calendar.tem" -->
<% End If %>

<!-- #include virtual="/calendar/includes/legend.inc" -->

&nbsp;<br>
&nbsp;<br>

<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->	
