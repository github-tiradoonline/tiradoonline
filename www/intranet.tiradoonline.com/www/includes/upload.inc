<%
'  For examples, documentation, and your own free copy, go to:
'  http://www.freeaspupload.net
'  Note: You can copy and use this script for free and you can make changes
'  to the code, but you cannot remove the above comment.


'Changes:
'Aug 2, 2005: Add support for checkboxes and other input elements with multiple values
'Jan 6, 2009: Lars added ASP_CHUNK_SIZE
'Sep 3, 2010: Enforce UTF-8 everywhere; new function to convert byte array to unicode string

const DEFAULT_ASP_CHUNK_SIZE = 300000

const adModeReadWrite = 3
const adTypeBinary = 1
const adTypeText = 2
const adSaveCreateOverWrite = 2
'FileName = ""

Class FreeASPUpload
	Public UploadedFiles
	Public FormElements

	Private VarArrayBinRequest
	Private StreamRequest
	Private uploadedYet
	Private internalChunkSize

	Private Sub Class_Initialize()
		Set UploadedFiles = Server.CreateObject("Scripting.Dictionary")
		Set FormElements = Server.CreateObject("Scripting.Dictionary")
		Set StreamRequest = Server.CreateObject("ADODB.Stream")
		StreamRequest.Type = adTypeText
		StreamRequest.Open
		uploadedYet = false
		internalChunkSize = DEFAULT_ASP_CHUNK_SIZE
	End Sub
	
	Private Sub Class_Terminate()
		If IsObject(UploadedFiles) Then
			UploadedFiles.RemoveAll()
			Set UploadedFiles = Nothing
		End If
		If IsObject(FormElements) Then
			'FormElements.RemoveAll()
			'Set FormElements = Nothing
		End If
		StreamRequest.Close
		Set StreamRequest = Nothing
	End Sub

	Public Property Get Form(sIndex)
		Form = ""
		If FormElements.Exists(LCase(sIndex)) Then Form = FormElements.Item(LCase(sIndex))
	End Property

	Public Property Get Files()
		Files = UploadedFiles.Items
	End Property
	
    Public Property Get Exists(sIndex)
            Exists = false
            If FormElements.Exists(LCase(sIndex)) Then Exists = true
    End Property
        
    Public Property Get FileExists(sIndex)
        FileExists = false
            if UploadedFiles.Exists(LCase(sIndex)) then FileExists = true
    End Property
        
    Public Property Get chunkSize()
		chunkSize = internalChunkSize
	End Property

	Public Property Let chunkSize(sz)
		internalChunkSize = sz
	End Property

	'Calls Upload to extract the data from the binary request and then saves the uploaded files
	Public Sub Save(path)
		Dim streamFile, fileItem, filePath

		if Right(path, 1) <> "\" then path = path & "\"

		if not uploadedYet then Upload

		For Each fileItem In UploadedFiles.Items
			filePath = path & fileItem.FileName
			Set streamFile = Server.CreateObject("ADODB.Stream")
			streamFile.Type = adTypeBinary
			streamFile.Open
			StreamRequest.Position=fileItem.Start
			StreamRequest.CopyTo streamFile, fileItem.Length
			'Response.Write filePath
			streamFile.SaveToFile filePath, adSaveCreateOverWrite
			streamFile.close
			Set streamFile = Nothing
			fileItem.Path = filePath
		 Next
	End Sub
	
	public sub SaveOne(path, num, byref outFileName, byref outLocalFileName)
		Dim streamFile, fileItems, fileItem, fs

        set fs = Server.CreateObject("Scripting.FileSystemObject")
		if Right(path, 1) <> "\" then path = path & "\"

		if not uploadedYet then Upload
		if UploadedFiles.Count > 0 then
			fileItems = UploadedFiles.Items
			set fileItem = fileItems(num)
		
			outFileName = fileItem.FileName
			outLocalFileName = GetFileName(path, outFileName)
		
			Set streamFile = Server.CreateObject("ADODB.Stream")
			streamFile.Type = adTypeBinary
			streamFile.Open
			StreamRequest.Position = fileItem.Start
			StreamRequest.CopyTo streamFile, fileItem.Length
			streamFile.SaveToFile path & outLocalFileName, adSaveCreateOverWrite
			streamFile.close
			Set streamFile = Nothing
			fileItem.Path = path & filename
		end if
	end sub

	Public Function SaveBinRequest(path) ' For debugging purposes
		StreamRequest.SaveToFile path & "\debugStream.bin", 2
	End Function

	Public Sub DumpData() 'only works if files are plain text
		Dim i, aKeys, f
		response.write "Form Items:<br />"
		aKeys = FormElements.Keys
		For i = 0 To FormElements.Count -1 ' Iterate the array
			response.write "Keys(i) = " & FormElements.Item(aKeys(i)) & "<br />"
		Next
		response.write "Uploaded Files:<br />"
		For Each f In UploadedFiles.Items
			response.write "Name: " & f.FileName & "<br />"
			response.write "Type: " & f.ContentType & "<br />"
			response.write "Start: " & f.Start & "<br />"
			response.write "Size: " & f.Length & "<br />"
		 Next
   	End Sub

	Public Sub Upload()
		Dim nCurPos, nDataBoundPos, nLastSepPos
		Dim nPosFile, nPosBound
		Dim sFieldName, osPathSep, auxStr
		Dim readBytes, readLoop, tmpBinRequest
		
		'RFC1867 Tokens
		Dim vDataSep
		Dim tNewLine, tDoubleQuotes, tTerm, tFilename, tName, tContentDisp, tContentType
		tNewLine = String2Byte(Chr(13))
		tDoubleQuotes = String2Byte(Chr(34))
		tTerm = String2Byte("--")
		tFilename = String2Byte("filename=""")
		tName = String2Byte("name=""")
		tContentDisp = String2Byte("Content-Disposition")
		tContentType = String2Byte("Content-Type:")

		uploadedYet = true

		'on error resume next
			' Copy binary request to a byte array, on which functions like InstrB and others can be used to search for separation tokens
			readBytes = internalChunkSize
			VarArrayBinRequest = Request.BinaryRead(readBytes)
			VarArrayBinRequest = midb(VarArrayBinRequest, 1, lenb(VarArrayBinRequest))
				'Response.Write VarArrayBinRequest
				'Response.Write "Here"
				'Response.End
			Do Until readBytes < 1
				tmpBinRequest = Request.BinaryRead(readBytes)
				if readBytes > 0 then
					VarArrayBinRequest = VarArrayBinRequest & midb(tmpBinRequest, 1, lenb(tmpBinRequest))
				end if
			Loop
			StreamRequest.WriteText(VarArrayBinRequest)
			StreamRequest.Flush()
			if Err.Number <> 0 then 
				response.write "<br /><br /><B>System reported this error:</B><p>"
				response.write Err.Description & "<p>"
				response.write "The most likely cause for this error is the incorrect setup of AspMaxRequestEntityAllowed in IIS MetaBase. Please see instructions in the <A HREF='http://www.freeaspupload.net/freeaspupload/requirements.asp'>requirements page of freeaspupload.net</A>.<p>"
				'Exit Sub
			end if
		'on error goto 0 'reset error handling

		nCurPos = FindToken(tNewLine,1) 'Note: nCurPos is 1-based (and so is InstrB, MidB, etc)

		If nCurPos <= 1  Then Exit Sub
		 
		'vDataSep is a separator like -----------------------------21763138716045
		vDataSep = MidB(VarArrayBinRequest, 1, nCurPos-1)

		'Start of current separator
		nDataBoundPos = 1

		'Beginning of last line
		nLastSepPos = FindToken(vDataSep & tTerm, 1)

		Do Until nDataBoundPos = nLastSepPos
			
			nCurPos = SkipToken(tContentDisp, nDataBoundPos)
			nCurPos = SkipToken(tName, nCurPos)
			sFieldName = ExtractField(tDoubleQuotes, nCurPos)

			nPosFile = FindToken(tFilename, nCurPos)
			nPosBound = FindToken(vDataSep, nCurPos)
			
			If nPosFile <> 0 And  nPosFile < nPosBound Then
				Dim oUploadFile
				Set oUploadFile = New UploadedFile
				
				nCurPos = SkipToken(tFilename, nCurPos)
				auxStr = ExtractField(tDoubleQuotes, nCurPos)
                ' We are interested only in the name of the file, not the whole path
                ' Path separator is \ in windows, / in UNIX
                ' While IE seems to put the whole pathname in the stream, Mozilla seem to 
                ' only put the actual file name, so UNIX paths may be rare. But not impossible.
                osPathSep = "\"
                if InStr(auxStr, osPathSep) = 0 then osPathSep = "/"
				oUploadFile.FileName = Right(auxStr, Len(auxStr)-InStrRev(auxStr, osPathSep))
				FileName = oUploadFile.FileName
				if (Len(oUploadFile.FileName) > 0) then 'File field not left empty
					nCurPos = SkipToken(tContentType, nCurPos)
					
                    auxStr = ExtractField(tNewLine, nCurPos)
                    ' NN on UNIX puts things like this in the stream:
                    '    ?? python py type=?? python application/x-python
					oUploadFile.ContentType = Right(auxStr, Len(auxStr)-InStrRev(auxStr, " "))
					nCurPos = FindToken(tNewLine, nCurPos) + 4 'skip empty line
					
					oUploadFile.Start = nCurPos+1
					oUploadFile.Length = FindToken(vDataSep, nCurPos) - 2 - nCurPos
					
					If oUploadFile.Length > 0 Then UploadedFiles.Add LCase(sFieldName), oUploadFile
				End If
			Else
				Dim nEndOfData, fieldValueUniStr
				nCurPos = FindToken(tNewLine, nCurPos) + 4 'skip empty line
				nEndOfData = FindToken(vDataSep, nCurPos) - 2
				fieldValueuniStr = ConvertUtf8BytesToString(nCurPos, nEndOfData-nCurPos)
				If Not FormElements.Exists(LCase(sFieldName)) Then 
					FormElements.Add LCase(sFieldName), fieldValueuniStr
				else
                    FormElements.Item(LCase(sFieldName))= FormElements.Item(LCase(sFieldName)) & ", " & fieldValueuniStr
                end if 

			End If

			'Advance to next separator
			nDataBoundPos = FindToken(vDataSep, nCurPos)
		Loop
	End Sub

	Private Function SkipToken(sToken, nStart)
		SkipToken = InstrB(nStart, VarArrayBinRequest, sToken)
		If SkipToken = 0 then
			Response.write "Error in parsing uploaded binary request. The most likely cause for this error is the incorrect setup of AspMaxRequestEntityAllowed in IIS MetaBase. Please see instructions in the <A HREF='http://www.freeaspupload.net/freeaspupload/requirements.asp'>requirements page of freeaspupload.net</A>.<p>"
			'Response.End
		end if
		SkipToken = SkipToken + LenB(sToken)
	End Function

	Private Function FindToken(sToken, nStart)
		FindToken = InstrB(nStart, VarArrayBinRequest, sToken)
	End Function

	Private Function ExtractField(sToken, nStart)
		Dim nEnd
		nEnd = InstrB(nStart, VarArrayBinRequest, sToken)
		If nEnd = 0 then
			Response.write "Error in parsing uploaded binary request."
			'Response.End
		end if
		ExtractField = ConvertUtf8BytesToString(nStart, nEnd-nStart)
	End Function

	'String to byte string conversion
	Private Function String2Byte(sString)
		Dim i
		For i = 1 to Len(sString)
		   String2Byte = String2Byte & ChrB(AscB(Mid(sString,i,1)))
		Next
	End Function

	Private Function ConvertUtf8BytesToString(start, length)	
		StreamRequest.Position = 0
	
	    Dim objStream
	    Dim strTmp
	    
	    ' init stream
	    Set objStream = Server.CreateObject("ADODB.Stream")
	    objStream.Charset = "utf-8"
	    objStream.Mode = adModeReadWrite
	    objStream.Type = adTypeBinary
	    objStream.Open
	    
	    ' write bytes into stream
	    StreamRequest.Position = start+1
	    StreamRequest.CopyTo objStream, length
	    objStream.Flush
	    
	    ' rewind stream and read text
	    objStream.Position = 0
	    objStream.Type = adTypeText
	    strTmp = objStream.ReadText
	    
	    ' close up and return
	    objStream.Close
	    Set objStream = Nothing
	    ConvertUtf8BytesToString = strTmp	
	End Function
End Class

Class UploadedFile
	Public ContentType
	Public Start
	Public Length
	Public Path
	Private nameOfFile

    ' Need to remove characters that are valid in UNIX, but not in Windows
    Public Property Let FileName(fN)
        nameOfFile = fN
        nameOfFile = SubstNoReg(nameOfFile, "\", "_")
        nameOfFile = SubstNoReg(nameOfFile, "/", "_")
        nameOfFile = SubstNoReg(nameOfFile, ":", "_")
        nameOfFile = SubstNoReg(nameOfFile, "*", "_")
        nameOfFile = SubstNoReg(nameOfFile, "?", "_")
        nameOfFile = SubstNoReg(nameOfFile, """", "_")
        nameOfFile = SubstNoReg(nameOfFile, "<", "_")
        nameOfFile = SubstNoReg(nameOfFile, ">", "_")
        nameOfFile = SubstNoReg(nameOfFile, "|", "_")
    End Property

    Public Property Get FileName()
        FileName = nameOfFile
    End Property

    'Public Property Get FileN()ame
End Class


' Does not depend on RegEx, which is not available on older VBScript
' Is not recursive, which means it will not run out of stack space
Function SubstNoReg(initialStr, oldStr, newStr)
    Dim currentPos, oldStrPos, skip
    If IsNull(initialStr) Or Len(initialStr) = 0 Then
        SubstNoReg = ""
    ElseIf IsNull(oldStr) Or Len(oldStr) = 0 Then
        SubstNoReg = initialStr
    Else
        If IsNull(newStr) Then newStr = ""
        currentPos = 1
        oldStrPos = 0
        SubstNoReg = ""
        skip = Len(oldStr)
        Do While currentPos <= Len(initialStr)
            oldStrPos = InStr(currentPos, initialStr, oldStr)
            If oldStrPos = 0 Then
                SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, Len(initialStr) - currentPos + 1)
                currentPos = Len(initialStr) + 1
            Else
                SubstNoReg = SubstNoReg & Mid(initialStr, currentPos, oldStrPos - currentPos) & newStr
                currentPos = oldStrPos + skip
            End If
        Loop
    End If
End Function

Function GetFileName(strSaveToPath, FileName)
'This function is used when saving a file to check there is not already a file with the same name so that you don't overwrite it.
'It adds numbers to the filename e.g. file.gif becomes file1.gif becomes file2.gif and so on.
'It keeps going until it returns a filename that does not exist.
'You could just create a filename from the ID field but that means writing the record - and it still might exist!
'N.B. Requires strSaveToPath variable to be available - and containing the path to save to
    Dim Counter
    Dim Flag
    Dim strTempFileName
    Dim FileExt
    Dim NewFullPath
    dim objFSO, p
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Counter = 0
    p = instrrev(FileName, ".")
    FileExt = mid(FileName, p+1)
    strTempFileName = left(FileName, p-1)
    NewFullPath = strSaveToPath & "\" & FileName
    Flag = False
    
    Do Until Flag = True
        If objFSO.FileExists(NewFullPath) = False Then
            Flag = True
            GetFileName = Mid(NewFullPath, InstrRev(NewFullPath, "\") + 1)
        Else
            Counter = Counter + 1
            NewFullPath = strSaveToPath & "\" & strTempFileName & Counter & "." & FileExt
        End If
    Loop
End Function 

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    Upload.Save(UploadFile)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
        next
    else
        SaveFiles = "No file selected for upload or the file name specified in the upload form does not correspond to a valid file in the system."
    end if
	SaveFiles = SaveFiles & "<br />Enter a number = " & Upload.Form("enter_a_number") & "<br />"
	SaveFiles = SaveFiles & "Checkbox values = " & Upload.Form("checkbox_values") & "<br />"
	SaveFiles = SaveFiles & "List values = " & Upload.Form("list_values") & "<br />"
	SaveFiles = SaveFiles & "Text area = " & Upload.Form("t_area") & "<br />"
end function
 
 function OutputForm()
%>
    <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="uploadTester.asp" onSubmit="return onSubmitForm();">
	<B>File names:</B><br />
    File 1: <input name="attach1" type="file" size=35><br />
    File 2: <input name="attach2" type="file" size=35><br />
    File 3: <input name="attach3" type="file" size=35><br />
    File 4: <input name="attach4" type="file" size=35><br />
    <br /> 
	<!-- These input elements are obviously optional and just included here for demonstration purposes -->
	<B>Additional fields (demo):</B><br />
	Enter a number: <input type="text" name="enter_a_number"><br />
    Checkbox values: <input type="checkbox" value="1" name="checkbox_values"> 1 &nbsp;&nbsp;<input type="checkbox" value="2" name="checkbox_values"> 2<br />
    Drop-down list (with multiple selection): <br />	   
    <select name="list_values" class="Element" MULTIPLE>
        <option value='frist' > First</option>
        <option value='second' > Second</option>
        <option value='third' > Third</option>
    </select><br />
    <textarea rows="2" cols="20" name="t_area">Test text area</textarea><br />
	<!-- End of additional elements -->
    <input style="margin-top:4" type=submit value="Upload">
    </form>
<%
end function

function TestEnvironment()
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not exist.</B><br />The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    fileName = UploadDirectory & "\test.pdf"
    'on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have write permissions.</B><br />The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.FileDelete(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have delete permissions</B>, although it does have write permissions.<br />Change the permissions for IUSR_<I>computername</I> on this folder."
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br />Check the Requirements page for information about upgrading your ADODB libraries."
        exit function
    end if
    Set streamTest = Nothing
end function

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    Upload.Save(UploadDirectory)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
        next
    else
        SaveFiles = "No file selected for upload or the file name specified in the upload form does not correspond to a valid file in the system."
    end if
	SaveFiles = SaveFiles & "<br />Enter a number = " & Upload.Form("enter_a_number") & "<br />"
	SaveFiles = SaveFiles & "Checkbox values = " & Upload.Form("checkbox_values") & "<br />"
	SaveFiles = SaveFiles & "List values = " & Upload.Form("list_values") & "<br />"
	SaveFiles = SaveFiles & "Text area = " & Upload.Form("t_area") & "<br />"
end function

%>