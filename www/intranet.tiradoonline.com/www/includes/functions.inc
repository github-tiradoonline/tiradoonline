<%
	Function BloodPressureColor(v_BloodPressure, v_BloodPressureBottom)
		bloodpressure_color = ""
		If NOT isNull(v_BloodPressureBottom) Then
			If CInt(v_BloodPressureBottom) >= 90 Then
				bloodpressure_color = "#ff0000"
			Else
				bloodpressure_color = "#000000"
			End If
		End If
		
		BloodPressureColor = "<font color=""" & bloodpressure_color & """><b>" & v_BloodPressure & "</b></font>"
	End Function

	Function Button(Button_name, Button_value, Button_classname, Button_style, Button_title, Button_onclick)
		s_val = "<input " & _
				"type=""button"" " & _
				"id=""" & Button_name & """ " & _
				"name=""" & Button_name & """ " & _
				"class=""" & Button_classname & """ " & _
				"style=""" & Button_style & """ " & _
				"title=""" & Button_title & """ " & _
				"value=""" & Button_value & """ " & _
				"onclick=""" & Button_onclick & """ " & _
				"/>"
		Button = s_val
	End Function
	
	Function ConvertToJSON(ByVal rs, ByVal labelName)'Converts recordset to JSON data
        Dim data, columnCount, colIndex, rowIndex, rowCount, rsArray
		data = ""
        If Not rs.EOF Then
            data = labelName & ":["
            data = "["
            rsArray = rs.GetRows()
            rowIndex = 0
        End If

        ' Retrieve the total no. of rows (second dimension of the array)
        rowCount = ubound(rsArray,2)
        'Retrive the total no. of columns/fields (first dimension of the array)
        columnCount = ubound(rsArray,1)
        
		'Loop through the array holding the resultset and display records
        'Loop through rows as the outer loop
        
		For rowIndex = 0 to rowCount
          	data = data & vbCrLF & "{" & vbCrLF & vbTab
            'Loop through columns/fields as inner loop
            For colIndex = 0 to columnCount
            	'data = data &  """" & rs.Fields(colIndex).Name & """" & ":""" & rsArray(colIndex,rowIndex) & """"
                data = data &  """" & rs.Fields(colIndex).Name & """ : """ & rsArray(colIndex,rowIndex) & """"
                
				If colIndex < columnCount Then
                	data = data & "," & vbCrLF & vbTab
               End If
          	Next 'Move on to next column/field is there is one
            
			data = data & vbCrLF & "}"
            
			If rowIndex < rowCount Then
            	data = data & ","
            End If
      	Next 'Move on to next row if there is one
        
		data = data & "]"
        'rs.Close
        
		ConvertToJSON = data
	End Function
	
	Function CreateReminder(subject, location, reminderStartTime, reminderEndTime)
    		reminderEvent = "BEGIN:VCALENDAR" & vbCrLF & _
    		"VERSION:2.0" & vbCrLF & _
    		"PRODID:-//hacksw/handcal//NONSGML v1.0//EN" & vbCrLF & _
    		"BEGIN:VEVENT" & vbCrLF & _
    		"DTSTART:" + reminderStartTime & vbCrLF & _
    		"DTEND:" + reminderEndTime & vbCrLF & _
    		"SUMMARY:" + subject & vbCrLF & _
    		"LOCATION:" + location & vbCrLF & _
    		"END:VEVENT" & vbCrLF & _
			"END:VCALENDAR" & vbCrLF
			CreateReminder = reminderEvent
	End Function

	Function DatePicker(fieldname)
		txt =  vbCrLF & "$( '#" & fieldname & "' ).datepicker({" & vbCrLF & _
				"showOn: ""button""," & vbCrLF & _
				"buttonImage: ""/images/icons/calendar.gif""," & vbCrLF & _
				"buttonImageOnly: true" & vbCrLF & _
				"});" & vbCrLF
		DatePicker = txt
	End Function
	
	Function DaysBox(DateBoxName, DateBoxValue, cssClass)
		x_str = ""
		x_str = x_str & "<select name=""" & DateBoxName & """ class=""" & cssClass & """>" & vbCrLF
		If DateBoxValue = "" OR isNull(DateBoxValue) Then DateBoxValue = 1
		For x = 1 to 31
			If Trim(CStr(DateBoxValue)) = CStr(x) Then
				x_str = x_str & "<option value=""" & x & """ SELECTED>" & x & "</option>" & vbCrLF
			Else
				x_str = x_str & "<option value=""" & x & """>" & x & "</option>" & vbCrLF
			End If
		Next
	
		Set ors_Select = Nothing
	
		x_str = x_str & "</select>"
		DaysBox = x_str
	End Function

	Function DisplayContent(content, contentLengh)
		v_content = ""
		
		If Len(content) > content Then
			v_content = Left(content, contentLength) & ".........."
		Else
			v_content = content
		End If

		DisplayContent = v_content
	End Function

	Function DrugTestColor(v_DrugTest, v_DrugTestResult)
		DrugTest_color = ""
		If NOT isNull(v_DrugTestResult) Then
			If CBool(v_DrugTestResult) Then
				DrugTest_color = BANKING_SUB_THEME
			Else
				DrugTest_color = "#ff0000"
			End If
		End If
		
		DrugTestColor = "<font color=""" & DrugTest_color & """><b>" & v_DrugTest & "</b></font>"
	End Function

	Sub ExportToExcel(sql_string)
		contents = ""
		v_sql = "sp_ExportToExcel"
		Set ors = oConn.Execute(v_sql)
		Counter = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		
		Set ors = oConn.Execute(sql_string)
		If NOT ors.EOF Then
			Set objFields = ors.Fields

			For intLoop = 0 To (objFields.Count - 1)
				If intLoop = 0 Then
	        		contents = contents & """" &  objFields.Item(intLoop).Name & """"
				Else
	        		contents = contents & ", """ &  objFields.Item(intLoop).Name & """"
				End If
    		Next
			
			contents = contents & vbCRLF 
			
			
			Do Until ors.EOF

				For intLoop = 0 To (objFields.Count - 1)
					If intLoop = 0 Then
		        		contents = contents & """" &  ors.Fields(intLoop).Value & """"
					Else
	        			contents = contents & vbTab & """" &  ors.Fields(intLoop).Value & """"
					End If
    			Next

				contents = contents & vbCRLF 
			
				ors.MoveNext
			Loop
		End If
		
		v_FileName = Server.MapPath("/export") & "\" & Counter & ".csv"

		'Response.Write "Writing to file: " & v_FileName
		Response.Write contents & vbCRLF
		
		
		FileWrite v_FileName, contents
		
		
		Response.End
		
	End Sub
	
	Sub FileDelete(FileName)
		Set FileObj = Server.CreateObject("Scripting.FileSystemObject")
		If NOT FileObj.FileExists(FileName) Then
			Set f = FileObj.FileDelete(FileName)
			Set f = Nothing
		End If
		Set FileObj = Nothing
	End Sub

	Function FilenameWithoutExtension(File_Name)
	  	Result = File_Name
  		i = InStrRev(File_Name, ".")
  		If ( i > 0 ) Then
    		Result = Mid(File_Name, 1, i - 1)
  		End If
  		FilenameWithoutExtension = Result
	End Function
	
	Function FileRead(FileName)
		'On Error Resume Next
		Set FileReadObj = CreateObject("Scripting.FileSystemObject")
		If Err.Number > 0 Then Response.Write "<li>" & Err.Description
		Set InStream = FileReadObj.OpenTextFile(FileName)
		If Err.Number > 0 Then Response.Write "<li>" & Err.Description
		FileContents = Trim(Instream.ReadAll)
		If Err.Number > 0 Then Response.Write "<li>" & Err.Description
		InStream.Close
		Set InStream = Nothing
		Set FileReadObj = Nothing
		FileRead = FileContents
		Err.Clear
	End Function
		
	Function FileWrite(FileName, FileText)
		On Error Resume Next
		Set FileObj = CreateObject("Scripting.FileSystemObject")
		Set OutStream = FileObj.CreateTextFile(FileName, true)
		If Err.Number > 0 Then 
			Response.Write "FileName:&nbsp;" & FileName & "<br />"
			Response.Write "<li>" & Err.Description & "<br />"
		End If
		OutStream.Write FileText
		If Err.Number > 0 Then Response.Write "<li>" & Err.Description & "<br />"
		OutStream.Close
		Set OutStream = Nothing
		Set FileObj = Nothing
		Err.Clear
	End Function
	
	Sub FolderCreate(folder_name)
		Set FileObj = Server.CreateObject("Scripting.FileSystemObject")
		If NOT FileObj.FolderExists(folder_name) Then
			Set f = FileObj.CreateFolder(folder_name)
			Set f = Nothing
		End If
		Set FileObj = Nothing
	End Sub

	Function FolderExists(folder_name)
		folder_exists = false
		Set FileObj = Server.CreateObject("Scripting.FileSystemObject")
		If FileObj.FolderExists(folder_name) Then folder_exists = true
		Set FileObj = Nothing
		
		FolderExists = folder_exists
	End Function

	Function formOpen(form_name, action, method)
		formOpen="<form action=""" & action & """ id=""" & form_name & """ name=""" & form_name & """ method=""" & method & """>"
	End Function
	
	Function FormatBanking(v_Banking)
		s_Banking = v_Banking
		If s_Banking < 0 Then s_Banking = Abs(FormatNumber(s_Banking, 2))
		FormatBanking = s_Banking
	End Function

	Function FormatFileName(v_FormatFileName)
		FormatFileName = Replace(v_FormatFileName, " ", "_")
	End Function

	Function FormatJavaScript(MessageText)
		tmp = MessageText
		tmp = Replace(tmp, "'", "\'")
		FormatJavaScript = tmp
	End Function

	Function FormatText(MessageText)
		MessageText = MessageText & " "
		MessageText = Replace(MessageText, Chr(10), "<br />")
		MessageText = Replace(MessageText, vbCrLF, "<p>")
		MessageText = Replace(MessageText, vbTab, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
		FormatText = MessageText
	End Function

	Function FormatWebsite(v_FormatWebsite)
		v_FormatWebsite = Replace(v_FormatWebsite, "https://", "")
		FormatWebsite = LCase(Replace(v_FormatWebsite, "http://", ""))
	End Function

    Function formFileUpload(textbox_name, textbox_size, textbox_value, textbox_css, textbox_title, errormessage)
    	formFileUpload = "<input type=""file"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "style=""width:" & textbox_size & "px"" " & _
                      "class=""" & textbox_css & """ " & _
                      "title=""" & textbox_title & """ " & _
                      "errormessage=""" & errormessage & """ " & _
                      "value=""" & textbox_value & """><span class=""ErrorMessage"" style=""display:none""></span>" & vbCrLF
	End Function

    Function formHidden(textbox_name, textbox_value)
    	formHidden = "<input type=""hidden"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "value=""" & textbox_value & """ />" & vbCrLF
	End Function

    Function formPassword(textbox_name, textbox_size, textbox_value, textbox_css, textbox_title, errormessage)
    	formPassword = "<input type=""password"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "size=""" & textbox_size & """ " & _
                      "class=""" & textbox_css & """ " & _
                      "title=""" & textbox_title & """ " & _
                      "errormessage=""" & errormessage & """ " & _
                      "value=""" & textbox_value & """><span class=""ErrorMessage"" style=""display:none""></span>"
	End Function

    Function formTextArea(TextArea_name, TextArea_value, width, height, TextArea_css, TextArea_title, errormessage)
    	formTextArea = "<textarea " & _
                      "id=""" & TextArea_name & """ " & _
        			  "name=""" & TextArea_name & """ " & _
                      "style=""width:" & width & "px;height:" & height & "px;"" " & _
                      "class=""" & TextArea_css & """ " & _
                      "title=""" & TextArea_title & """ " & _
                      "errormessage=""" & errormessage & """>" & _
                      TextArea_value & "</textarea><span class=""ErrorMessage"" style=""float:right;display:none""></span>"
	End Function

    Function formTextAreaTabIndex(TextArea_name, TextArea_value, width, height, TextArea_css, TextArea_title, textbox_tabindex, errormessage)
    	formTextAreaTabIndex = "<textarea " & _
                      "id=""" & TextArea_name & """ " & _
        			  "name=""" & TextArea_name & """ " & _
                      "style=""width:" & width & "px;height:" & height & "px;"" " & _
                      "class=""" & TextArea_css & """ " & _
                      "tabindex=""" & textbox_tabindex & """ " & _
                      "title=""" & TextArea_title & """ " & _
                      "errormessage=""" & errormessage & """>" & _
                      TextArea_value & "</textarea><span class=""ErrorMessage"" style=""float:right;display:none""></span>"
	End Function

    Function formTextBox(textbox_name, textbox_size, textbox_value, textbox_css, textbox_title, errormessage)
    	formTextBox = "<input type=""text"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "size=""" & textbox_size & """ " & _
                      "class=""" & textbox_css & """ " & _
                      "title=""" & textbox_title & """ " & _
                      "errormessage=""" & errormessage & """ " & _
                      "value=""" & textbox_value & """><span class=""ErrorMessage"" style=""display:none""></span>"
	End Function

    Function formTextBoxJavaScript(textbox_name, textbox_size, textbox_value, textbox_css, textbox_title, textbox_javascript, errormessage)
    	formTextBoxJavaScript = "<input type=""text"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "size=""" & textbox_size & """ " & _
                      "class=""" & textbox_css & """ " & _
                      "title=""" & textbox_title & """ " & _
                      "errormessage=""" & errormessage & """ " & _
                      textbox_javascript & " " & _
                      "value=""" & textbox_value & """><span class=""ErrorMessage"" style=""float:right;display:none""></span>"
	End Function

    Function formTextBoxTabIndex(textbox_name, textbox_size, textbox_value, textbox_css, textbox_title, textbox_tabindex, errormessage)
    	formTextBoxTabIndex = "<input type=""text"" " & _
                      "id=""" & textbox_name & """ " & _
        			  "name=""" & textbox_name & """ " & _
                      "size=""" & textbox_size & """ " & _
                      "class=""" & textbox_css & """ " & _
                      "title=""" & textbox_title & """ " & _
                      "tabindex=""" & textbox_tabindex & """ " & _
                      "errormessage=""" & errormessage & """ " & _
                      "value=""" & textbox_value & """><span class=""ErrorMessage"" style=""float:right;display:none""></span>"
	End Function
	
	Sub HandleError(var_err)
		If var_err.Number <> 0 Then
			redirectError = "/errors/error.asp?ErrorNumber=" & Server.URLEncode(var_err.Number) & "&ErrorDescription=" & Server.URLEncode(var_err.Description)
			Response.Redirect redirectError
			'Response.Write "<b>Error#:</b><br />" & var_err.Number & ":" & "<br/><br/>"
			'Response.Write "<b>Description:</b><br />" & var_err.Description & "<p />"
			Response.End
		End If
		
		var_err.Clear
	End Sub
	
	Function Header(class_name, headertext)
		Header = "<div class=""" & class_name & """><h1 class=""Header"" style=""padding: 5px;"">" & headertext & "</h1></div>" & vbCrLf & "<p>" & vbCrLF
	End Function
	
	Function HeartRateColor(v_HeartRate)
		heart_rate_color = ""
		If NOT isNull(HeartRate) Then
			If CInt(v_HeartRate) >= 110 OR CInt(v_HeartRate) <= 90 Then
				heart_rate_color = "#ff0000"
			Else
				heart_rate_color = "#000000"
			End If
		End If
		
		HeartRateColor = "<font color=""" & heart_rate_color & """><b>" & v_HeartRate & "</b></font>"
	End Function

	Function HTMLFormat(format_string)
    	v_format_string = format_string
        If NOT isNULL(v_format_string) AND Len(v_format_string) > 0 Then
        	v_format_string = Replace(v_format_string, " ", "&nbsp;")
        	v_format_string = Replace(v_format_string, " ", "&nbsp;")
        End If
        HTMLFormat = v_format_string
    End Function

	Function HTMLFormat2(format_string)
    	v_format_string = format_string
        If NOT isNULL(v_format_string) AND Len(Trim(v_format_string)) > 0 Then
        	'v_format_string = Replace(v_format_string, Chr(13), "<p />")
        	v_format_string = Replace(v_format_string, Chr(10), "<br />")
        End If
        HTMLFormat2 = v_format_string
    End Function
	
	Function OxygenColor(v_Oxygen)
		oxygen_color = ""
		If NOT isNull(Oxygen) Then
			If CInt(v_Oxygen) >= 120 OR CInt(v_Oxygen) <= 90 Then
				oxygen_color = "#ff0000"
			Else
				oxygen_color = "#000000"
			End If
		End If
		
		OxygenColor = "<font color=""" & oxygen_color & """><b>" & v_Oxygen & "</b></font>"
	End Function

	Function PageLogText(page_text)
		If isNULL(page_text) OR Len(page_text) = 0 Then 
			PageLogText = ""
		Else
			pagetext = ""
			pageArray = Split(page_text, "|||||")
			For x = 0 To UBound(pageArray)
				pagetext = pagetext & pageArray(x) & "<br />"
			Next
			
			PageLogText = pagetext
		End If
	End Function

	Function ProfitLoss (num)
		If CDbl(num) < 0 Then
			ProfitLoss = "<span style='color:#ff0000;font-weight:bold;'>$" & FormatNumber(num, 2) & "</span>"
		Else
			ProfitLoss = "<span style='color:#639a63;font-weight:bold;'>$" & FormatNumber(num, 2) & "</span>"
		End If
	End Function

	Function ProfitLoss2 (num)
		If CDbl(num) < 0 Then
			ProfitLoss2 = "<span style='color:#ff0000;font-weight:bold;'>$" & FormatNumber(num, 2) & "</span>"
		Else
			ProfitLoss2 = "<span style='color:#4BCC4B;font-weight:bold;'>$" & FormatNumber(num, 2) & "</span>"
		End If
	End Function

	Function SelectBox(connection, sqlString, SelectBoxName, SelectBoxValue, cssClass, SelectBoxTitle)
		If isNull(SelectBoxValue) Then SelectBoxValue = ""
		x_str = ""
		WriteDebugger sqlString, Debugging, 0
		'Response.Write sqlString
		'Response.End
		Set ors_Select = connection.Execute(sqlString)
		If isNull(SelectBoxValue) Then SelectBoxValue = ""
		If NOT ors_Select.EOF Then
			x_str = x_str & "<select id=""" & SelectBoxName & """ name=""" & SelectBoxName & """ class=""" & cssClass & """ title=""" & SelectBoxTitle & """>" & vbCrLF
			Do Until ors_Select.EOF
				selectField = ors_Select.Fields(0).Value
				if isNull(selectField) Then selectField = ""
				'Response.Write Trim(CStr(SelectBoxValue)) & "=" & Trim(CStr(selectField)) & "<br />"
				If Trim(CStr(SelectBoxValue)) = Trim(CStr(selectField)) Then
					x_str = x_str & "<option value=""" & selectField & """ SELECTED>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				Else
					x_str = x_str & "<option value=""" & selectField & """>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				End If
				ors_Select.MoveNext
			Loop
			ors_Select.Close
			x_str = x_str & "</select>"
			End If
	
		Set ors_Select = Nothing
	
		SelectBox = x_str
	End Function

	Function SelectBoxTabIndex(connection, sqlString, SelectBoxName, SelectBoxValue, cssClass, tabindex, SelectBoxTitle)
		x_str = ""
		x_str = x_str & "<select id=""" & SelectBoxName & """ name=""" & SelectBoxName & """ class=""" & cssClass & """ tabindex=""" & tabindex & """ title=""" & SelectBoxTitle & """>" & vbCrLF
		WriteDebugger sql, Debugging, 0
		Set ors_Select = connection.Execute(sqlString)
		If isNull(SelectBoxValue) Then SelectBoxValue = ""
		If NOT ors_Select.EOF Then
			Do Until ors_Select.EOF
				'Response.Write Trim(CStr(SelectBoxValue)) & "=" & Trim(CStr(ors_Select.Fields(0).Value)) & "<br />"
				If Trim(CStr(SelectBoxValue)) = Trim(CStr(ors_Select.Fields(0).Value)) Then
					x_str = x_str & "<option value=""" & ors_Select.Fields(0).Value & """ SELECTED>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				Else
					x_str = x_str & "<option value=""" & ors_Select.Fields(0).Value & """>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				End If
				ors_Select.MoveNext
			Loop
			ors_Select.Close
		End If
	
		Set ors_Select = Nothing
	
		x_str = x_str & "</select>"
		SelectBoxTabIndex = x_str
	End Function

	Function SelectBoxNA(connection, sqlString, SelectBoxName, SelectBoxValue, cssClass, SelectBoxTitle)
		x_str = ""
		x_str = x_str & "<select name=""" & SelectBoxName & """ class=""" & cssClass & """ title=""" & SelectBoxTitle & """>" & vbCrLF
		'Response.Write "sqlString:" & sqlString	
		'If Debugging Then W(sqlString)
		Set ors_Select = connection.Execute(sqlString)
		If isNull(SelectBoxValue) Then SelectBoxValue = ""
		If NOT ors_Select.EOF Then
			If Trim(CStr(SelectBoxValue)) = "" Then
				x_str = x_str & "<option value="""" SELECTED>N/A</option>" & vbCrLF
			Else
				x_str = x_str & "<option value="""" >N/A</option>" & vbCrLF
			End If
			Do Until ors_Select.EOF
				'Response.Write Trim(CStr(SelectBoxValue)) & "=" & Trim(CStr(ors_Select.Fields(0).Value)) & "<br />"
				If Trim(CStr(SelectBoxValue)) = Trim(CStr(ors_Select.Fields(0).Value)) Then
					x_str = x_str & "<option value=""" & ors_Select.Fields(0).Value & """ SELECTED>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				Else
					x_str = x_str & "<option value=""" & ors_Select.Fields(0).Value & """>" & ors_Select.Fields(1).Value & "</option>" & vbCrLF
				End If
				ors_Select.MoveNext
			Loop
			ors_Select.Close
		End If
	
		Set ors_Select = Nothing
	
		x_str = x_str & "</select>"
		SelectBoxNA = x_str
	End Function
	
	Sub SendEmail(v_ToEmail, v_FromEmail, v_CC, v_Subject, v_BodyText, v_isHTML)
		On Error Resume Next 
		v_UserID = Session("UserID")
		If v_UserID = "" Then v_UserID = "1001"
		sql = "sp_Settings_get " & v_UserID
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			SMTPServer = ors("SMTPServer")
			SMTPServerUserName = ors("SMTPServerUserName")
			SMTPServerPassword = ors("SMTPServerPassword")
			SMTPServerPort = ors("SMTPServerPort")
			ors.Close
		End If

		Const cdoSendUsingPickup = 1 'Send message using the local SMTP service pickup directory.
		Const cdoSendUsingPort = 2 'Send the message using the network (SMTP over the network).

		Const cdoAnonymous = 0 'Do not authenticate
		Const cdoBasic = 1 'basic (clear-text) authentication
		Const cdoNTLM = 2 'NTLM

		Set myMail = Server.CreateObject("CDO.Message")
		
		myMail.Subject = v_Subject
		myMail.From = v_FromEmail
		myMail.To = v_ToEmail
		If v_CC <> "" OR v_CC <> null Then 
			myMail.Cc = v_CC
		End If
		myMail.HTMLBody = v_BodyText

		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort

		'Name or IP of remote SMTP server
		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTPServer

		'Server port
		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTPServerPort

		'Type of authentication, NONE, Basic (Base64 encoded), NTLM
		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasic

		'Your UserID on the SMTP server
		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = SMTPServerUserName

		'Your password on the SMTP server
		myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = SMTPServerPassword
		
		myMail.Configuration.Fields.Update

 		myMail.Send
		
		set myMail = Nothing
	End Sub
	
	Function SettingsDirectory(directoryName)
		directory = ""
		sql = "SELECT " & directoryName & " FROM Settings WHERE UserID = " & Session("UserID")
		Set ors = oConn.Execute(sql)
		If NOT ors.EOF Then
			directory = ors.Fields(0).Value
			ors.Close
		End If
		Set ors = Nothing
		
		SettingsDirectory = directory
	End Function

	Function ShortenString(string)
		stringLength = 20
		v_string = string
		
		If Len(string) > stringLength Then
			v_string = Left(string, stringLength) & "...."
		End If
		
		ShortenString = v_string
	End Function
	
	Function ShowDBField(fieldName)
		ShowDBField = Left(fieldName, Len(fieldName))
	End Function
	
	Function ShowMap(vAddress)
		WindowArray = Split(vAddress, " ")
		If UBound(WindowArray) > 0 Then
			WindowName = "Window" & WindowArray(0)
		Else
			WindowName = "Window1"
		End If

		vAddress = "/includes/google/map.asp?Address=" & Server.URLEncode(vAddress)
		vtext = ""
		vtext = vtext & "<span onclick=""OpenMap('" & WindowName & "', '" & vAddress & "')"">" & MAP_ICON & "</span>"
		ShowMap = vtext
	End Function
	
	Function SQLEncode(v_sql)
		SQLEncode = Replace(v_sql, "'", "''")
	End Function

	Function SnippetGroupGet(v_SnippetGroupID)
		sql = "SELECT SnippetGroupName FROM SnippetGroups WHERE SnippetGroupID = " & v_SnippetGroupID
		WriteDebugger sql, Debugging, 0
		Set v_SnippetGroup_rs = oConn.Execute(sql)
		v_SnippetGroup = v_SnippetGroup_rs("SnippetGroupName")
		v_SnippetGroup_rs.Close
		Set v_SnippetGroup_rs = Nothing
		SnippetGroupGet = v_SnippetGroup
	End Function

	Function SQLTotalRows(recordSet)
		total_rows = 0
		If NOT recordSet.EOF Then
			Do Until recordSet.EOF
				total_rows = total_rows + 1
				recordSet.MoveNext
			Loop
			recordSet.MoveFirst
		End If
		SQLTotalRows = total_rows
	End Function

	'*****************
	' IF ADDED UPDATE navigation.inc
	'*****************
	
	Function SubNavigation(sub_nav)
		Set objSubNavigation = Server.CreateObject("Scripting.Dictionary")
		objSubNavigation.Add "1", "administration"
		objSubNavigation.Add "2", "banking"
		objSubNavigation.Add "3", "health"
		objSubNavigation.Add "4", "creditcards"
		objSubNavigation.Add "5", "jobs"
		objSubNavigation.Add "6", "recovery"
		objSubNavigation.Add "7", "timesheet"
		objSubNavigation.Add "8", "tiradoonline"
		objSubNavigation.Add "9", "monthly_expenses"
		objSubNavigation.Add "10", "collection_agency"
		objSubNavigation.Add "11", "servers"

		sub_navigation = ""

		For Each Item in objSubNavigation
			If objSubNavigation(Item) <> sub_nav Then
		        sub_navigation = sub_navigation & "$('#subnav_" & objSubNavigation(Item) & "').hide();" & vbCrLF
			End If
		
		Next 
		For i = 1 To objSubNavigation.Count
			subnav = objSubNavigation.Item(i)
			If subnav <> sub_nav Then
		        'sub_navigation = sub_navigation & "$('#subnav_" & objSubNavigation.Item(i) & "').hide();" & vbCrLF
			End If
	    Next

		Set objSubNavigation = Nothing

		SubNavigation = sub_navigation
	End Function
	
	Function Submit_Button(SubmitButton_name, SubmitButton_value, SubmitButton_classname, SubmitButton_style, SubmitButton_title)
		s_val = "<input " & _
				"type=""submit"" " & _
				"id=""" & SubmitButton_name & """ " & _
				"name=""" & SubmitButton_name & """ " & _
				"class=""" & SubmitButton_classname & """ " & _
				"style=""" & SubmitButton_style & """ " & _
				"title=""" & SubmitButton_title & """ " & _
				"value=""" & SubmitButton_value & """ />"
		Submit_Button = s_val
	End Function
	
	Function SugarColor(v_Sugar)
		sugar_color = ""
		If NOT isNull(v_Sugar) Then
			If CInt(v_Sugar) >= 200 OR CInt(v_Sugar) <= 75 Then
				sugar_color = "#ff0000"
			Else
				sugar_color = "#000000"
			End If
		End If
		
		SugarColor = "<font color=""" & sugar_color & """><b>" & v_Sugar & "</b></font>"
	End Function
	
	Function TemperatureColor(v_Temperature)
		Temperature_color = ""
		If NOT isNull(v_Temperature) Then
			If CInt(v_Temperature) >= 100 Then
				Temperature_color = "#ff0000"
			Else
				Temperature_color = "#000000"
			End If
		End If
		
		TemperatureColor = "<font color=""" & Temperature_color & """><b>" & v_Temperature & "</b></font>"
	End Function

	Function WriteDebugger(write_string, v_debugging, response_end)
		sql2 = "sp_ExecutedSQLScripts_insert " & _
			"'" & SQLEncode(Request.ServerVariables("SERVER_NAME")) & "', " & _
			"'" & SQLEncode(write_string) & "'"

		oConn.Execute sql2

		If v_debugging AND (UCase(Request.ServerVariables("SERVER_NAME")) <> "BankingINTRANET.TIRADOONLINE.COM" AND UCase(Request.ServerVariables("SERVER_NAME")) <> "BankingINTRANET.THEODORETIRADO.COM") Then 
			Response.Write "<div style='background:#dddddd; color:#ff0000; border:solid 1px #000000; padding:5px; font-weight:bold'>" & write_string & "</div>"
			'if response_end Then Response.End
		End If
	End Function
%>