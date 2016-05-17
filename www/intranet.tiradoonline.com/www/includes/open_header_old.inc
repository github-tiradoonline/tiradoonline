<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><%= PageTitle %>: <%= Session("FullName") %></title>
	<!-- #include virtual="/includes/css/global.css" -->
	<link href="/includes/jquery/themes/base/jquery-ui.css" rel="stylesheet">
	<script src="/includes/jquery/jquery.js"></script>
	<script src="/includes/jquery/ui/jquery-ui.js"></script>
	<script src="/includes/jquery/ui/jquery.contextmenu.js"></script>
	<!-- #include virtual="/includes/js/functions.js" -->
</head>


<body onLoad="SetDateTime()">


<div id="LoginBoxSite">

<table cellspacing=0 cellpadding=0 border=0 align="left" width="1200">
<tr valign="top">
	<td align=right valign=top>
		<!-- #include virtual="/includes/navigation.inc" -->
	</td>
	<td valign=top width="100%">
		<a href="/home.asp"><img src="/images/header/logo_banner.gif" alt="Bankingintranet.tiradoonline.com" width="572" height="82" border="0"></a>

		<table cellspacing=1 cellpadding=0 width="100%" border=0>
		<tr class="<%= PageTheme %>">
			<td class="Header">
				<table cellspacing=0 cellpadding=3 border=0 width="100%">
				<tr class="<%= PageTheme %>">
					<td>&nbsp;&nbsp;&nbsp;<%= HeaderTitle %>:&nbsp;&nbsp;<%= Session("FullName") %></td>
					<td align="right"><span id="TodaysDate" name="TodaysDate" />&nbsp;&nbsp;&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<table cellspacing=1 cellpadding=0 border=0>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>
				