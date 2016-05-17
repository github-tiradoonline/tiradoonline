<script type="text/javascript">
	function add_Test(TestTypeID) {
		var TestResultID = document.getElementById('TestResult' + TestTypeID).options[document.getElementById('TestResult' + TestTypeID).selectedIndex].value;
		var redirect_URL = "<%= SCRIPT_NAME %>?Template=<%= Template %>";
		redirect_URL += "&TestTypeID=" + TestTypeID;
		redirect_URL += "&SubmitButton=<%= Server.URLEncode("Create Test") %>";
		redirect_URL += "&TestDate=" + escape(document.getElementById('TestDate' + TestTypeID).value);
		redirect_URL += "&TestLocation=" + escape(document.getElementById('TestLocation' + TestTypeID).value);
		redirect_URL += "&TestComments=" + escape(document.getElementById('TestComments' + TestTypeID).value);
		redirect_URL += "&TestResultID=" + TestResultID;
		location.href = redirect_URL;
	}
	
	function changeImage(objs, imagesrc) {
		alert(objs + ":" + imagesrc);
		//$($imagename).attr('src', $imagesrc);
		document.getElementById(objs).src = imagesrc;
	}

	function DaysArray(n) {
		for (var i = 1; i <= n; i++) {
			this[i] = 31
			if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
			if (i==2) {this[i] = 29}
	   } 
	   return this
	}
	
	function daysInFebruary (year){
		// February has 29 days in any year evenly divisible by four,
	    // EXCEPT for centurial years which are not also divisible by 400.
	    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
	}

	function DeleteItem(confirm_string, location_url) {
		try { 
			if(confirm(confirm_string))
				location.href = location_url;
		}
		catch(err) { 
			alert(err.description);
		}
	}

	function DeleteSnippet(snippetid) {
		v_location = "<%= SCRIPT_NAME %>?SubmitButton=DELETE&SnippetID=" + snippetid
		if(confirm('Are you sure you want to delete this snippet?'))
			location.href = v_location;
	}

	function displayError(formObj)
	{
		formObj.next().html('<%= X_ICON %>' + formObj.attr('errormessage') + '&nbsp;&nbsp;&nbsp;&nbsp;');
		formObj.next().fadeIn(1000);
		formObj.removeClass().addClass("AdministrationElement");
	}
	
	function EmailInvoice(redirectURL)
	{
		var cc = prompt("CC:");

		if (cc != null) {
			redirectURL += "&CC=" + escape(cc);
			location.href = redirectURL;
		}
	}
	
	function EmailMonthlyStatement(redirect_url) {
	<% If Trim(Request.Cookies("BankingEmailCC")) = "" OR  Trim(Request.Cookies("BankingEmailCC")) = "null" Then %>
		var cc = prompt("CC:");
	<% Else %>
		var cc = prompt("CC:", "<%= Trim(Request.Cookies("BankingEmailCC")) %>");
	<% End If %>
		if (cc != null) {
			redirect_url += "&CC=" + escape(cc);
			location.href = redirect_url
		}
	}

	function EmailSnippet(snippetid) {
		v_location = "<%= SCRIPT_NAME %>?SubmitButton=EmailSnippet&SnippetID=" + snippetid

		var cc = prompt("CC:");
		
		if (cc != null) {
			v_location += "&CC=" + escape(cc);
			location.href = v_location;
		}
	}

	function formatAMPM (num) {
		if(parseInt(num) > 12) 
			num = "PM";
		else
			num = "PM";
			
		return num;
	}
	
	function formatHour (num) {
		if(parseInt(num) > 12) 
			num -= 12;
			
		return num;
	}

	function formatTwoDigitNumber (num) {
		if(parseInt(num) < 10)
			return "0" + num;
		else
			return num;
	}

	function getCookie(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for(var i=0; i<ca.length; i++)
  		{
  			var c = ca[i].trim();
  			if (c.indexOf(name)==0) return c.substring(name.length,c.length);
  		}
		return "";
	}

	function isDate(dtStr){
		var dtCh = "/";
		var minYear = 1900;
		var maxYear = 2100;

		var daysInMonth = DaysArray(12)
		var pos1=dtStr.indexOf(dtCh)
		var pos2=dtStr.indexOf(dtCh,pos1+1)
		var strMonth=dtStr.substring(0,pos1)
		var strDay=dtStr.substring(pos1+1,pos2)
		var strYear=dtStr.substring(pos2+1)
		strYr=strYear
		if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
		if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
		for (var i = 1; i <= 3; i++) {
			if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
		}
		month=parseInt(strMonth)
		day=parseInt(strDay)
		year=parseInt(strYr)
		if (pos1==-1 || pos2==-1){
			//alert("The date format should be : mm/dd/yyyy")
			return false
		}
		if (strMonth.length<1 || month<1 || month>12){
			//alert("Please enter a valid month")
			return false
		}
		if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
			//alert("Please enter a valid day")
			return false
		}
		if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
			//alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
			return false
		}
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
			//alert("Please enter a valid date")
			return false
		}
		return true
	}
	
	function isEmail(email_string) {
		validEmail = true;
		
    	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

		if(email_string == "") {
			validEmail = false;
		} 
		else if(!filter.test(email_string)) {
			validEmail = false;
		}

		return validEmail;
	}
	
	function isInteger(s){
		var i;
	    for (i = 0; i < s.length; i++){   
	        // Check that current character is number.
	        var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
	    }
	    // All characters are numbers.
	    return true;
	}
	 	
	function isNaNumber(num) {
		if(num == '' || isNaN(num))
			return true;
		else
			return false;
	}
	
	function isTime(strTime) {
		/*
			format1: hh:mm:ss tt - 2:30:00 PM
			format2: hh:mm tt - 2:30 PM
			format3: hh:mm- 4:30		
		*/
		if(strTime.length < 9)
		{
			strTime = strTime.replace(" AM", ":00 AM");
			strTime = strTime.replace(" PM", ":00 PM");
			strTime = strTime.replace(" Am", ":00 AM");
			strTime = strTime.replace(" aM", ":00 PM");
			strTime = strTime.replace(" Pm", ":00 AM");
			strTime = strTime.replace(" pM", ":00 PM");
			strTime = strTime.replace(" am", ":00 AM");
			strTime = strTime.replace(" pm", ":00 PM");
		}
		//alert(strTime);
		var strTime1 = /^(\d{1,2})(\:)(\d{2})\2(\d{2})(\ )\w[AM|PM|am|pm]$/;
		var strTime2 = /^(\d{1,2})(\:)(\d{2})(\ )\w[A|P|a|p]\w[M|m]$/;
		var strTime3 = /^(\d{1,2})(\:)(\d{1,2})$/;
		
		var strFormat1 = strTime.match(strTime1);
		var strFormat2 = strTime.match(strTime2);
		var strFormat3 = strTime.match(strTime3);

		// Check to see if it matches one of the 3 Format Strings.
		if (strFormat1 == null && strFormat2 == null && strFormat3 == null) {
			return false;
		}
		else if (strFormat1 != null) {
			// Validate for this format: 3:48:01 PM
			if (strFormat1[1] > 12 || strFormat1[1] < 00) {
				return false;
			}
			if (strFormat1[3] > 59 || strFormat1[3] < 00) {
				return false;	
			}
			if (strFormat1[4] > 59 || strFormat1[4] < 00) {
				return false;	
			}
		}
		else if (strFormat2 != null) {
			// Validate for this format: 3:48 PM
			if (strFormat2[1] > 12 || strFormat2[1] < 00) {
				return false;
			}
			if (strFormat2[3] > 59 || strFormat2[3] < 00) {
				return false;	
			}
		}
		else if (strFormat3 != null) {
			// Validate for this format: 15:48
			if (strFormat3[1] > 23 || strFormat3[1] < 00) {
				return false;
			}
			if (strFormat3[3] > 59 || strFormat3[3] < 00) {
				return false;	
			}
		}
		return true;
	}
	
	function logoutClick() {
		if(confirm('Are you sure you want to logout?'))
			location.href = '/default.asp?SubmitButton=Logout';
	}
	
	function OpenMap(windowname, vAddress){
		if (window.showModalDialog) 
			window.showModalDialog(vAddress, windowname, "dialogWidth:<%= Application("MapWindowWidth") %>px;dialogHeight:<%= Application("MapWindowHeight") %>px;center:yes;location:no;resizable:no;scroll:no;status:no;toolbar:left:100;top:100");
		else
			window.open(vAddress, windowname, "width=<%= Application("MapWindowWidth") %>,height=<%= Application("MapWindowHeight") %>,location=no,toolbar=no,directories=no,status=no,menubar=yes,scrollbars=no,resizable=no,modal=yes,left=100,top=100");
	}
	
	function promptCreateFolder(folder, prompt_text) {
		var foldername = prompt(prompt_text);
		
		if(foldername != null) {
			folder += foldername;
			
			v_url = "<%= SCRIPT_NAME %>?SubmitButton=CreateFolder&CurrentDirectory=" + folder
			location.href= v_url
		}
	}
	
	function promptSnippetGroup() {
		var snippetgroupname = prompt("Create a new Snippet Group");
		v_url = "<%= SCRIPT_NAME %>?SubmitButton=CreateNewGroup&SnippetGroupName=" + escape(snippetgroupname)
		if(snippetgroupname != "" && snippetgroupname != null)
			location.href= v_url
	}

	function setCookie(cname, cvalue, exdays)
	{
		var d = new Date();
		d.setTime(d.getTime()+(exdays*24*60*60*1000));
		var expires = "expires="+d.toGMTString();
		document.cookie = cname + "=" + cvalue + "; " + expires;
	}
	
	function SetDateTime() {
		tday  =new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
		tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
		
		d = new Date();
		nday   = d.getDay();
		nmonth = d.getMonth();
		ndate  = d.getDate();
		nyear = d.getYear();
		nhour  = d.getHours();
		nmin   = d.getMinutes();
		nsec = d.getSeconds();
	
		if(nyear<1000) nyear=nyear+1900;
		
		if(nhour ==  0) {ap = " AM";nhour = 12;} 
		else if(nhour <= 11) {ap = " AM";} 
		else if(nhour == 12) {ap = " PM";} 
		else if(nhour >= 13) {ap = " PM";nhour -= 12;}
		
		
		
		
		if(nmin <= 9) {nmin = "0" + nmin;}
		if(nsec <= 9) {nsec = "0" + nsec;}
		
		todaysDate = tday[nday] +",&nbsp;&nbsp;" + 
					 tmonth[nmonth]+ " " + ndate + ", " + nyear + 
					 " "+ nhour + ":" + nmin + ":" + nsec + " " + ap;
					 
		$('#TodaysDate').html(todaysDate);
		setTimeout("SetDateTime()", 1000);
	}


	
	function SetDateTime2() {
		var formattedDate = new Date(Date.now());
		var Day = formattedDate.getDay();
		var Month =  formattedDate.getMonth();
		Month += 1;  // JavaScript months are 0-11
		var Year = formattedDate.getFullYear();
		var WeekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var WeekDayName = WeekDays[Day];
		var Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		var MonthName = Months[Month];
		
		var Hours = formattedDate.getHours();
		var Minutes = formattedDate.getMinutes();
		var Seconds = formattedDate.getSeconds();
		
		var todaysDate = WeekDayName + " " + MonthName + " " + Day + ", " + Year + " " + formatHour(Hours) + ":" + formatTwoDigitNumber(Minutes) + ":" + formatTwoDigitNumber(Seconds) + " " + formatAMPM(Hours);
		$('#TodaysDate').html(todaysDate);
		setTimeout("SetDateTime2()", 1000);
	}

	function showSnippet(snippet_group) {
		document.forms[0].SnippetGroupID.text = snippet_group;
	}
	
	function SQLEncode(sql_value)
	{
		return sql_value.replace("'", "''");
	}
	
	function stripCharsInBag(s, bag){
		var i;
	    var returnString = "";
	    // Search through string's characters one by one.
	    // If character is not in bag, append to returnString.
	    for (i = 0; i < s.length; i++){   
	        var c = s.charAt(i);
	        if (bag.indexOf(c) == -1) returnString += c;
	    }
	    return returnString;
	}

	function ValidateSnippets() {
		var SnippetName = document.forms[0].SnippetName.value;
		var Snippet = document.forms[0].Snippet.value;
		var errorsfound = false; 
		
		if(SnippetName == "") {
			alert("Enter Snippnet name");
			return false;
		}
		else if(Snippet == "") {
			alert("Enter Snippnet ");
			return false;
		}
		else {
			return true;
		}
	}
</script>

<!-- #include virtual="/includes/js/forms.js" -->
