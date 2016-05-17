<!-- #include virtual="/includes/login.inc" -->
<!-- #include virtual="/includes/globals.inc" -->
<%
	PageTheme = "healthTheme"
	PageThemeColor = HEALTH_THEME
	PageTitle = "Health"
	HeaderTitle = "Health"
	Response.Buffer = true
%>

<!-- #include virtual="/includes/open_connection.inc" -->
<!-- #include virtual="/includes/page_logs.inc" -->

<!-- #include virtual="/includes/functions.inc" -->

<%
	'ALLLLLLLLLLLLL
	checkboxMedicine = Trim(Request("checkboxMedicine"))
	checkboxHeartRate = Trim(Request("checkboxHeartRate"))
	checkboxOxygen = Trim(Request("checkboxOxygen"))
	checkboxBloodPressure = Trim(Request("checkboxBloodPressure"))
	checkboxTemperature = Trim(Request("checkboxTemperature"))
	checkboxSugar = Trim(Request("checkboxSugar"))
	checkboxWeight = Trim(Request("checkboxWeight"))

	'Response.WRite "checkboxMedicine = " & Trim(Request("checkboxMedicine")) & "<br>"
	'Response.WRite "checkboxHeartRate =" & Trim(Request("checkboxHeartRate")) & "<br>"
	'Response.WRite "checkboxBloodPressure =" & Trim(Request("checkboxBloodPressure")) & "<br>"
	'Response.WRite "checkboxTemperature =" & Trim(Request("checkboxTemperature")) & "<br>"
	'Response.WRite "checkboxSugar =" & Trim(Request("checkboxSugar")) & "<br>"

	'END OF ALLLLLLLLLLL
	DoctorID = Trim(Request("DoctorID"))
	FirstName = Trim(Request("FirstName"))
	LastName = Trim(Request("LastName"))
	TelephoneNumber = Trim(Request("TelephoneNumber"))

	PharmacyID = Trim(Request("PharmacyID"))
	PharmacyName = Trim(Request("PharmacyName"))
	PharmacyAddress = Trim(Request("PharmacyAddress"))
	PharmacyCity = Trim(Request("PharmacyCity"))
	PharmacyStateID = Trim(Request("PharmacyStateID"))
	If PharmacyStateID = "" Then PharmacyStateID = Application("StateID")
	PharmacyZipCode = Trim(Request("PharmacyZipCode"))
	PharmacyTelephoneNumber = Trim(Request("PharmacyTelephoneNumber"))

	HeartRateID = Trim(Request("HeartRateID"))
	HeartRate = Trim(Request("HeartRate"))
	HeartRateDate = Trim(Request("HeartRateDate"))
	If HeartRateDate = "" Then HeartRateDate = FormatDateTime(Now, 2)
	HeartRateTime = Trim(Request("HeartRateTime"))
	If HeartRateTime = "" Then HeartRateTime = FormatDateTime(Now, 3)
	HeartRateComments = Trim(Request("HeartRateComments"))

	OxygenID = Trim(Request("OxygenID"))
	Oxygen = Trim(Request("Oxygen"))
	OxygenDate = Trim(Request("OxygenDate"))
	If OxygenDate = "" Then OxygenDate = FormatDateTime(Now, 2)
	OxygenTime = Trim(Request("OxygenTime"))
	If OxygenTime = "" Then OxygenTime = FormatDateTime(Now, 3)
	OxygenComments = Trim(Request("OxygenComments"))

	InsulinID = Trim(Request("InsulinID"))
	InsulinDate = Trim(Request("InsulinDate"))
	If InsulinDate = "" Then InsulinDate = FormatDateTime(Now, 2)
	InsulinTime = Trim(Request("InsulinTime"))
	If InsulinTime = "" Then InsulinTime = FormatDateTime(Now, 3)

	MedicineDose = "1"
	MedicineDoseID = Trim(Request("MedicineDoseID"))
	MedicineDoseDate = Trim(Request("MedicineDoseDate"))
	If MedicineDoseDate = "" Then MedicineDoseDate = FormatDateTime(Now, 2)
	MedicineDoseDate2 = Trim(Request("MedicineDoseDate2"))
	If MedicineDoseDate2 = "" Then MedicineDoseDate2 = FormatDateTime(Now, 2)
	MedicineDoseTime = Trim(Request("MedicineDoseTime"))
	If MedicineDoseTime = "" Then MedicineDoseTime = FormatDateTime(Now, 3)
	MedicineDoseTime2 = Trim(Request("MedicineDoseTime2"))
	If MedicineDoseTime2 = "" Then MedicineDoseTime2 = FormatDateTime(Now, 3)
	MedicineDoseDateTime = Trim(MedicineDoseDate & " " & MedicineDoseTime)
	MedicineDoseDateTime2 = Trim(MedicineDoseDate2 & " " & MedicineDoseTime2)

	Amount = Trim(Request("Amount"))
	MedicineDoseDescription = Trim(Request("MedicineDoseDescription"))
	MedicineDoseType = Trim(Request("MedicineDoseType"))
	
	MedicineID = Trim(Request("MedicineID"))	
	GenericName = Trim(Request("GenericName"))	
	MedicineName = Trim(Request("MedicineName"))
	PrescriptionNumber = Trim(Request("PrescriptionNumber"))
	MedicineDescription = Trim(Request("MedicineDescription"))	
	SearchMedicineName = Trim(Request("SearchMedicineName"))
	
	MedicineDosePackageID = Trim(Request("MedicineDosePackageID"))	
	MedicineDosePackageName = Trim(Request("MedicineDosePackageName"))	
	MedicineDosePackageItemID = Trim(Request("MedicineDosePackageItemID"))	
	
	MedicineRefillID = Trim(Request("MedicineRefillID"))
	MedicineID = Trim(Request("MedicineID"))
	DoctorID = Trim(Request("DoctorID"))
	PharmacyID = Trim(Request("PharmacyID"))
	RefillOrderDate = Trim(Request("RefillOrderDate"))
	RefillOrderPickupDate = Trim(Request("RefillOrderPickupDate"))
	RefillDateFilled = Trim(Request("RefillDateFilled"))
	RefillAmount = Trim(Request("RefillAmount"))
	If RefillAmount = "" Then RefillAmount = 0
	DailyAmount = Trim(Request("DailyAmount"))
	If DailyAmount = "" Then DailyAmount = 0
	RefillTimes = Trim(Request("RefillTimes"))
	If RefillTimes = "" Then RefillTimes = 0
	RefillUntilDate = Trim(Request("RefillUntilDate"))
	RefillDiscardDate = Trim(Request("RefillDiscardDate"))
	RefillDescription = Trim(Request("RefillDescription"))

	TemperatureID = Trim(Request("TemperatureID"))
	Temperature = Trim(Request("Temperature"))
	TemperatureDate = Trim(Request("TemperatureDate"))
	If TemperatureDate = "" Then TemperatureDate = FormatDateTime(Now, 2)
	TemperatureTime = Trim(Request("TemperatureTime"))
	If TemperatureTime = "" Then TemperatureTime = FormatDateTime(Now, 3)
	TemperatureComments = Trim(Request("TemperatureComments"))

	WeightID = Trim(Request("WeightID"))
	Weight = Trim(Request("Weight"))
	WeightLocation = Trim(Request("WeightLocation"))
	WeightDate = Trim(Request("WeightDate"))
	If WeightDate = "" Then WeightDate = FormatDateTime(Now, 2)
	WeightTime = Trim(Request("WeightTime"))
	If WeightTime = "" Then WeightTime = FormatDateTime(Now, 3)
	WeightComments = Trim(Request("WeightComments"))
	
	TestTypeID = Trim(Request("TestTypeID"))
	TestTypeName = Trim(Request("TestTypeName"))
	
	TestID = Trim(Request("TestID"))
	TestDate = Trim(Request("TestDate"))
	TestLocation = Trim(Request("TestLocation"))
	TestResultID = Trim(Request("TestResultID"))
	TestComments = Trim(Request("TestComments"))

	SugarID = Trim(Request("SugarID"))
	Sugar = Trim(Request("Sugar"))
	SugarDate = Trim(Request("SugarDate"))
	If SugarDate = "" Then SugarDate = FormatDateTime(Now, 2)
	SugarTime = Trim(Request("SugarTime"))
	If SugarTime = "" Then SugarTime = FormatDateTime(Now, 3)
	SugarComments = Trim(Request("SugarComments"))

	BloodPressureID = Trim(Request("BloodPressureID"))
	BloodPressureTop = Trim(Request("BloodPressureTop"))
	BloodPressureBottom = Trim(Request("BloodPressureBottom"))
	BloodPressureDate = Trim(Request("BloodPressureDate"))
	If BloodPressureDate = "" Then BloodPressureDate = FormatDateTime(Now, 2)
	BloodPressureTime = Trim(Request("BloodPressureTime"))
	If BloodPressureTime = "" Then BloodPressureTime = FormatDateTime(Now, 3)
	BloodPressureComments = Trim(Request("BloodPressureComments"))

	UnitID = Trim(Request("UnitID"))
	Units = Trim(Request("Units"))
	UnitName = Trim(Request("UnitName"))

	HospitalID = Trim(Request("HospitalID"))
	HospitalName = Trim(Request("HospitalName"))
	HospitalAddress = Trim(Request("HospitalAddress"))
	HospitalCity = Trim(Request("HospitalCity"))
	HospitalStateID = Trim(Request("HospitalStateID"))
	If HospitalStateID = "" Then HospitalStateID = Application("StateID")
	HospitalZipCode = Trim(Request("HospitalZipCode"))
	HospitalPhone = Trim(Request("HospitalPhone"))
	HospitalWebsite = Trim(Request("HospitalWebsite"))
	If HospitalWebsite <> "" Then HospitalWebsite = FormatWebsite(HospitalWebsite)
	
	HospitalPositionID = Trim(Request("HospitalPositionID"))
	HospitalPositionName = Trim(Request("HospitalPositionName"))

	HospitalStaffID = Trim(Request("HospitalStaffID"))
	HospitalStaffName = Trim(Request("HospitalStaffName"))
	Notes = Trim(Request("Notes"))
	
	BloodPressureDateTime = Trim(BloodPressureDate & " " & BloodPressureTime)
	HeartRateDateTime = Trim(HeartRateDate & " " & HeartRateTime)
	OxygenDateTime = Trim(OxygenDate & " " & OxygenTime)
	InsulinDateTime = Trim(InsulinDate & " " & InsulinTime)
	SugarDateTime = Trim(SugarDate & " " & SugarTime)
	TemperatureDateTime = Trim(TemperatureDate & " " & TemperatureTime)
	WeightDateTime = Trim(WeightDate & " " & WeightTime)

	AllErrorMessage = Trim(Request("AllErrorMessage"))



	'***************************************************'
	'******************* Doctor ********************'
	'***************************************************'
	If SubmitButton = "Create Doctor" Then
		sql = "sp_Doctor_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(FirstName) & "', " & _
			  "'" & SQLEncode(LastName) & "', " & _
			  "'" & SQLEncode(TelephoneNumber) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Doctor added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Doctor" Then
		sql = "sp_Doctor_update " & _
			  DoctorID & ", " & _
		      "'" & SQLEncode(FirstName) & "', " & _
		      "'" & SQLEncode(LastName) & "', " & _
		      "'" & SQLEncode(TelephoneNumber) & "'"
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Doctor updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteDoctor" Then
		sql = "sp_Doctor_delete " & _
			  DoctorID
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Doctor deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If


	'***************************************************'
	'******************* Pharmacy ********************'
	'***************************************************'
	If SubmitButton = "Create Pharmacy" Then
		sql = "sp_Pharmacy_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(PharmacyName) & "', " & _
			  "'" & SQLEncode(PharmacyAddress) & "', " & _
			  "'" & SQLEncode(PharmacyCity) & "', " & _
			  SQLEncode(PharmacyStateID) & ", " & _
			  "'" & SQLEncode(PharmacyZipCode) & "', " & _
			  "'" & SQLEncode(PharmacyTelephoneNumber) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Pharmacy added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Pharmacy" Then
		sql = "sp_Pharmacy_update " & _
			  PharmacyID & ", " & _
		      "'" & SQLEncode(PharmacyName) & "', " & _
		      "'" & SQLEncode(PharmacyAddress) & "', " & _
		      "'" & SQLEncode(PharmacyCity) & "', " & _
			  SQLEncode(PharmacyStateID) & ", " & _
		      "'" & SQLEncode(PharmacyZipCode) & "', " & _
		      "'" & SQLEncode(PharmacyTelephoneNumber) & ""
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Pharmacy updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeletePharmacy" Then
		sql = "sp_Pharmacy_update " & _
			  PharmacyID
		WriteDebugger sql, Debugging, 0
		Response.Write sql
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Pharmacy deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If


	'***************************************************'
	'******************* HEART RATE ********************'
	'***************************************************'
	If SubmitButton = "Create Heart Rate" OR checkboxHeartRate = "1" Then
		sql = "sp_HeartRate_insert " & _
			  Session("UserID") & ", " & _
			  "'" & HeartRateDateTime & "', " & _
			  HeartRate & ", " &  _
			  "'" & SQLEncode(HeartRateComments) & "'"
		'Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Heart Rate added.")
		If checkboxHeartRate <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Heart Rate" Then
		sql = "sp_HeartRate_update " & _
			  HeartRateID & ", " & _ 
		      "'" & HeartRateDateTime & "', " & _
		      HeartRate & ", " & _
			  "'" & SQLEncode(HeartRateComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)


		HealthErrorMessage = Server.URLEncode("Heart Rate updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteHeartRate" Then
		sql = "sp_HeartRate_delete " & _
			  HeartRateID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)

		HealthErrorMessage = Server.URLEncode("Heart Rate deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If


	'***************************************************'
	'******************* Oxygen ********************'
	'***************************************************'
	If SubmitButton = "Create Oxygen" OR checkboxOxygen = "1" Then
		sql = "sp_Oxygen_insert " & _
			  Session("UserID") & ", " & _
			  "'" & OxygenDateTime & "', " & _
			  Oxygen & ", " &  _
			  "'" & SQLEncode(OxygenComments) & "'"
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Oxygen added.")
		If checkboxOxygen <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Oxygen" Then
		sql = "sp_Oxygen_update " & _
			  OxygenID & ", " & _ 
		      "'" & OxygenDateTime & "', " & _
		      Oxygen & ", " & _
			  "'" & SQLEncode(OxygenComments) & "'"
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)

		HealthErrorMessage = Server.URLEncode("Oxygen updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteOxygen" Then
		sql = "sp_Oxygen_delete " & _
			  OxygenID
		'Response.Write sql
		'Response.End
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)

		HealthErrorMessage = Server.URLEncode("Oxygen deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If






	'***************************************************'
	'******************* TEMPERATURE *******************'
	'***************************************************'
	If SubmitButton = "Create Temperature" OR checkboxTemperature = "1" Then
		sql = "sp_Temperature_insert " & _
			  Session("UserID") & ", " & _
			  "'" & TemperatureDateTime & "', " & _
			  Temperature & ", " & _
			  "'" & SQLEncode(TemperatureComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Temperature added.")
		If checkboxTemperature <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Temperature" Then
		sql = "sp_Temperature_update " & _
			  TemperatureID & ", " & _
			  "'" & TemperatureDateTime & "', " &_
		      Temperature & ", " & _
			  "'" & SQLEncode(TemperatureComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Temperature updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteTemperature" Then
		sql = "sp_Temperature_delete " & _
			  TemperatureID
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Temperature deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If






	'***************************************************'
	'******************* WEIGHT *******************'
	'***************************************************'
	If SubmitButton = "Create Weight" OR checkboxWeight = "1" Then
		sql = "sp_Weight_insert " & _
			  Session("UserID") & ", " & _
			  "'" & WeightDateTime & "', " & _
			  Weight & ", " & _
			  "'" & SQLEncode(WeightLocation) & "', " & _
			  "'" & SQLEncode(WeightComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Weight added.")
		If checkboxWeight <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Weight" Then
		sql = "sp_Weight_update " & _
			  WeightID & ", " & _
			  "'" & WeightDateTime & "', " &_
	 	      Weight & ", " & _
			  "'" & SQLEncode(WeightLocation) & "', " & _
			  "'" & SQLEncode(WeightComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Weight updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteWeight" Then
		sql = "sp_Weight_delete " & _
			  WeightID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Weight deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If






	'***************************************************'
	'******************* TEST TYPE *********************'
	'***************************************************'
	If SubmitButton = "Create Test Type" Then
		
		sql = "sp_TestType_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(TestTypeName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Test Type added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Test Type" Then
		sql = " sp_TestType_update " & _
			TestTypeID & ", " & _
		    "'" & SQLEncode(TestTypeName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Test Type updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* TESTS *************************'
	'***************************************************'
	If SubmitButton = "Create Test" Then
			For Each Item In Request.Form
				If Left(Item, 8) = "TestDate" Then
				 	TestArray = Split(Item, "_")
				 	TestTypeID = TestArray(1)
					If TestTypeID = Request("TestTypeID") Then
						v_TestTypeID = TestTypeID
						TestResultID = Request("TestResult_" & v_TestTypeID)
						TestDate = Request("TestDate_" & v_TestTypeID)
						TestLocation = Request("TestLocation_" & v_TestTypeID)
						TestComments = Request("TestComments_" & v_TestTypeID)
					End If
				End If
			Next
			sql = "sp_Test_insert " & _
				  Session("UserID") & ", " & _
				  TestTypeID & ", " & _
				  TestResultID & ", " & _
				  "'" & SQLEncode(TestDate) & "', " & _
				  "'" & SQLEncode(TestLocation) & "', " & _
			  	"'" & SQLEncode(TestComments) & "'"
		
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Test added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Test" Then
		sql = "sp_Test_update " & _
		      SQLEncode(TestTypeID) & ", " & _
		      SQLEncode(TestResultID) & ", " & _
		      "'" & SQLEncode(TestDate) & "', " & _
		      "'" & SQLEncode(TestLocation) & "', " & _
		      "'" & SQLEncode(TestComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Test Type updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Sugar ********************'
	'***************************************************'
	If SubmitButton = "Create Sugar" OR checkboxSugar = "1" Then
		sql = "sp_Sugar_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SugarDateTime & "', " & _
			  "'" & Sugar & "', " & _
			  "'" & SQLEncode(SugarComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Sugar added.")
		If checkboxSugar <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Sugar" Then
		sql = "sp_Sugar_update " & _
			  SugarID & ", " & _
			  "'" & SugarDateTime & "', " & _
			  Sugar & ", " & _
		      "'" & SQLEncode(SugarComments) & "'"
		WriteDebugger sql, Debugging, 0
		'Response.Write sql
		
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Sugar updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteSugar" Then
		sql = "sp_Sugar_delete " & _
			  SugarID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Sugar deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Unit ********************'
	'***************************************************'
	If SubmitButton = "Create Unit" Then
		sql = "sp_Unit_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(UnitName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Unit added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Unit" Then
		sql = "sp_Unit_update " & _
			   UnitID & ", " & _
		      "'" & SQLEncode(UnitName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Unit updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Hospital ********************'
	'***************************************************'
	If SubmitButton = "Create Hospital" Then
		sql = "sp_Hospital_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(HospitalName) & "', " & _
			  "'" & SQLEncode(HospitalAddress) & "', " & _
			  "'" & SQLEncode(HospitalCity) & "', " & _
			  HospitalStateID & ", " & _
			  "'" & SQLEncode(HospitalZipCode) & "', " & _
			  "'" & SQLEncode(HospitalPhone) & "', " & _
			  "'" & SQLEncode(HospitalWebsite) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Hospital" Then
		sql = "sp_Hospital_update " & _
		 	  HospitalID & ", " & _
			  "'" & SQLEncode(HospitalName) & "', " & _
			  "'" & SQLEncode(HospitalAddress) & "', " & _
			  "'" & SQLEncode(HospitalCity) & "', " & _
			  HospitalStateID & ", " & _
			  "'" & SQLEncode(HospitalZipCode) & "', " & _
			  "'" & SQLEncode(HospitalPhone) & "', " & _
			  "'" & SQLEncode(HospitalWebsite) & "'"
			Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Hospital Position ********************'
	'***************************************************'
	If SubmitButton = "Create Hospital Position" Then
		sql = "sp_HospitalPosition_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(HospitalPositionName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital Position added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Hospital Position" Then
		sql = "sp_HospitalPosition_update " & _
			  HospitalPositionID & ", " & _
		      "'" & SQLEncode(HospitalPositionName) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital Position updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If

	



	'***************************************************'
	'******************* Hospital Staff ********************'
	'***************************************************'
	If SubmitButton = "Create Staff" Then
		sql = "sp_HospitalStaff_insert " & _
			  Session("UserID") & ", " & _
			  HospitalID & ", " & _
			  HospitalPositionID & ", " & _
			  "'" & SQLEncode(FirstName) & "', " & _
			  "'" & SQLEncode(LastName) & "', " & _
			  "'" & SQLEncode(Notes) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital Staff added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HospitalID=" & HospitalID & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Staff" Then
		sql = "sp_HospitalStaff_update " & _
		      HospitalStaffID & ", " & _
			  HospitalID & ", " & _
			  HospitalPositionID & ", " & _
			  "'" & SQLEncode(FirstName) & "', " & _
			  "'" & SQLEncode(LastName) & "', " & _
			  "'" & SQLEncode(Notes) & "'"
		Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital Position updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HospitalStaffID=" & HospitalStaffID & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteStaff" Then
		sql = "sp_HospitalStaff_delete " & _
		      HospitalStaffID
		Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Hospital Position deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HospitalStaffID=" & HospitalStaffID & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Insulin ********************'
	'***************************************************'
	If SubmitButton = "Create Insulin" Then
		sql = "INSERT INTO Insulin " & _
		      "(UserID, InsulinDateTime, MedicineID, Units) VALUES (" & _
			  Session("UserID") & ", " & _
			  "'" & InsulinDateTime & "', " & _
			  MedicineID & ", " & _
			  Units & ")"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Insulin added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Insulin" Then
		sql = "UPDATE Insulin SET " & _
		      "MedicineID = " & MedicineID & ", " & _
			  "InsulinDateTime = '" & InsulinDateTime & "', " & _
		      "Units = " & Units & " " & _
			  "WHERE InsulinID = " & InsulinID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Insulin updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Medicine Dose ********************'
	'***************************************************'
	If SubmitButton = "Add Medicine Dose" OR checkboxMedicine = "1" Then
		If Amount <> "" Then
			sql = "sp_MedicineDose_insert " & _
				  "'" & MedicineDoseDateTime & "', " & _
				  MedicineID & ", " & _
				  Amount & ", " & _
				  "'" & SQLEncode(MedicineDoseDescription) & "'"
			
			WriteDebugger sql, Debugging, 0
			oConn.Execute(sql)
			HealthErrorMessage = Server.URLEncode("Medicine Dose added.")
			If checkboxMedicine <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
		Else
			sql = "sp_MedicineDose_MedicineDosePackage_insert " & _
					MedicineDosePackageID & ", " & _
				  	"'" & MedicineDoseDateTime2 & "'"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
			HealthErrorMessage = Server.URLEncode("Medicine Dose(s) added.")
			Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
		End If
	ElseIf SubmitButton = "Save Medicine Dose" Then
		If Amount = "" Then Amount = 0
		sql = "sp_MedicineDose_update " & _
		      MedicineDoseID & ", " & _
			  "'" & MedicineDoseDateTime & "', " & _
		      MedicineID & ", " & _
		      Amount & ", "  & _
			  "'" & MedicineDoseDescription & "'"
			 Response.Write sql
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine Dose updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteMedicineDose" Then
		sql = "sp_MedicineDose_delete " & _
		      MedicineDoseID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine Dose deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Medicine ********************'
	'***************************************************'
	If SubmitButton = "Create Medicine" Then
		sql = "sp_Medicine_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(MedicineName) & "', " & _
			  "'" & SQLEncode(GenericName) & "', " & _
			  "'" & SQLEncode(PrescriptionNumber) & "', " & _
			  UnitID & ", " & _
			  "'" & SQLEncode(MedicineDescription) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Medicine" Then
		sql = "sp_Medicine_update " & _
			  MedicineID & ", " & _
		      "'" & SQLEncode(MedicineName) & "', " & _
		      "'" & SQLEncode(GenericName) & "', " & _
		      "'" & SQLEncode(PrescriptionNumber) & "', " & _
		      UnitID & ", " & _
		      "'" & SQLEncode(MedicineDescription) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If





	'***************************************************'
	'******************* Medicine Dose Package ********************'
	'***************************************************'
	If SubmitButton = "Create Medicine Dose Package" Then
		sql = "sp_MedicineDosePackage_insert " & _
			  Session("UserID") & ", " & _
			  "'" & SQLEncode(MedicineDosePackageName) & "';"
		WriteDebugger sql, Debugging, 0
		Set ors = oConn.Execute(sql)
		MedicineDosePackageID = ors.Fields(0).Value
		ors.Close
		Set ors = Nothing
		
		MedicineArray = Split(MedicineID, ",")
		
		For x = 0 To UBound(MedicineArray)
			sql = "sp_MedicineDosePackageItem_insert " & _
				  MedicineDosePackageID & ", " & _
				  MedicineArray(x) & ", " & _
				  0 & ", " & _
				  "''"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
		Next

		HealthErrorMessage = Server.URLEncode("Medicine Dose Package added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Medicine Dose Package" Then
		sql = "sp_MedicineDosePackage_update " & _
			  MedicineDosePackageID & ", " & _
		      "'" & SQLEncode(MedicineDosePackageName) & "'"
		WriteDebugger sql, Debugging, 0
		'Response.Write sql
		'Resposne.End
		oConn.Execute(sql)

		sql = "sp_MedicineDosePackageItem_delete " & MedicineDosePackageID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql

		MedicineArray = Split(MedicineID, ",")
		
		For x = 0 To UBound(MedicineArray)
			sql = "sp_MedicineDosePackageItem_insert " & _
				  MedicineDosePackageID & ", " & _
				  MedicineArray(x) & ", " & _ 
				  0 & ", " & _
				  "''"
			WriteDebugger sql, Debugging, 0
			oConn.Execute sql
		Next
		HealthErrorMessage = Server.URLEncode("Medicine Dose Package saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Medicine Package" Then
		sql = "sp_MedicineDosePackage_update " & _
			  MedicineDosePackageID & ", " & _
		      "'" & SQLEncode(MedicineDosePackageName) & "'"
		WriteDebugger sql, Debugging, 0
		'Response.Write sql
		'Resposne.End
		oConn.Execute(sql)

		For Each Item in Request.Form
			If Left(Item, 7) = "Amount_" Then
				itemArray = Split(Item, "_")
				MedicineDosePackageItemID = itemArray(1)
				sql = "sp_MedicineDosePackageItem_update " & _
					  MedicineDosePackageItemID & ", " & _ 
					  Request.Form(Item) & ", " & _
					  "'" & SQLEncode(Trim(Request("Description_" & MedicineDosePackageItemID))) & "'"
				'Response.Write sql & "<br />"
				WriteDebugger sql, Debugging, 0
				oConn.Execute sql
			End If
		Next

		HealthErrorMessage = Server.URLEncode("Medicine Dose Package saved.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteMedicineDosePackage" Then
		sql = "sp_MedicineDosePackage_delete " & MedicineDosePackageID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql

		HealthErrorMessage = Server.URLEncode("Medicine Dose Package deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteMedicineDosePackageItem" Then
		sql = "sp_MedicineDosePackageItem_delete " & MedicineDosePackageItemID
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql

		HealthErrorMessage = Server.URLEncode("Medicine Dose Package Item deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&MedicineDosePackageID=" & MedicineDosePackageID & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Add Medicine to Package" Then
		sql = "sp_MedicineDosePackageItem_insert " & _
MedicineDosePackageID & ", " & _
			 MedicineID & ", " & _
			 Trim(Request("NewAmount")) & ", " & _
			 "'" & SQLEncode(Trim(Request("NewDescription"))) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute sql
		HealthErrorMessage = Server.URLEncode("Medicine added to Package")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
		
		




	'***************************************************'
	'******************* Medicine Refill ********************'
	'***************************************************'
		MedicineRefillID = ors("MedicineRefillID")
		MedicineID = ors("MedicineID")
		DoctorID = ors("DoctorID")
		PharmacyID = ors("PharmacyID")
		RefillDateFilled = ors("RefillDateFilled")
		RefillAmount = ors("RefillAmount")
		DailyAmount = ors("DailyAmount")
		RefillTimes = ors("RefillTimes")
		RefillUntilDate = ors("RefillUntilDate")
		RefillDiscardDate = ors("RefillDiscardDate")
		RefillDescription = ors("RefillDescription")
	End If

	If SubmitButton = "Create Medicine Refill" Then
		sql = "sp_MedicineRefill_insert " & _
			  MedicineID & ", " & _
			  DoctorID & ", " & _
			  PharmacyID & ", " & _
			  "'" & SQLEncode(RefillOrderDate) & "', " & _
			  "'" & SQLEncode(RefillOrderPickupDate) & "', " & _
			  "'" & SQLEncode(RefillDateFilled) & "', " & _
			  RefillAmount & ", " & _
			  DailyAmount & ", " & _
			  RefillTimes & ", " & _
			  "'" & SQLEncode(RefillUntilDate) & "', " & _
			  "'" & SQLEncode(RefillDiscardDate) & "', " & _
			  "'" & SQLEncode(RefillDescription) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine Refill added.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Medicine Refill" Then
		sql = "sp_MedicineRefill_update " & _
			  MedicineRefillID & ", " & _
		      MedicineID & ", " & _
		      DoctorID & ", " & _
		      PharmacyID & ", " & _
		      "'" & SQLEncode(RefillOrderDate) & "', " & _
		      "'" & SQLEncode(RefillOrderPickupDate) & "', " & _
		      "'" & SQLEncode(RefillDateFilled) & "', " & _
		      "" & RefillAmount & ", " & _
			  DailyAmount & ", " & _
		      RefillTimes & ", " & _
		      "'" & SQLEncode(RefillUntilDate) & "', " & _
		      "'" & SQLEncode(RefillDiscardDate) & "', " & _
		      "'" & SQLEncode(RefillDescription) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteMedicineRefill" Then
		sql = "sp_MedicineRefill_delete " & _
			  MedicineRefillID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Medicine deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If




	'***************************************************'
	'******************* BLOOD PRESSURE ****************'
	'***************************************************'
	If SubmitButton = "Create Blood Pressure" OR checkboxBloodPressure = "1" Then
		sql = "sp_BloodPressure_insert " & _
			  Session("UserID") & ", " & _
			  "'" & BloodPressureDateTime & "', " & _
			  BloodPressureTop & ", " & _
			  BloodPressureBottom & ", " & _
			  "'" & SQLEncode(BloodPressureComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Blood Pressure added.")
		If checkboxBloodPressure <> "1" Then Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "Save Blood Pressure" Then
		sql = "sp_BloodPressure_update " & _
			  BloodPressureID & ", " & _
			  "'" & BloodPressureDateTime & "', " & _
		      "" & BloodPressureTop & ", " & _
		      "" & BloodPressureBottom & ", " & _
			  "'" & SQLEncode(BloodPressureComments) & "'"
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Blood Pressure updated.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	ElseIf SubmitButton = "DeleteBloodPressure" Then
		sql = "sp_BloodPressure_delete " & _
			  BloodPressureID
		WriteDebugger sql, Debugging, 0
		oConn.Execute(sql)
		HealthErrorMessage = Server.URLEncode("Blood Pressure deleted.")
		Response.Redirect SCRIPT_NAME & "?Template=" & Template & "&HealthErrorMessage=" & HealthErrorMessage
	End If
	
	'AllErrorMessage = Server.URLEncode("Records inserted")
	If SubmitButton = "Create All" Then Response.Redirect SCRIPT_NAME & "?Template=all&AllErrorMessage=" & Server.URLEncode("Records inserted")

%>

<!-- #include virtual="/includes/open_header.inc" -->


<table>
<tr valign="top">
	<td>
 		<% If Template = "" Then %>
		<!-- #include file="templates/home.tem" -->
 		<% ElseIf Template = "all" Then %>
		<!-- #include file="templates/all.tem" -->
		<% ElseIf Template = "heart_rate" Then %>
		<!-- #include file="templates/heart_rate.tem" -->
		<% ElseIf Template = "oxygen" Then %>
		<!-- #include file="templates/oxygen.tem" -->
		<% ElseIf Template = "temperature" Then %>
		<!-- #include file="templates/temperature.tem" -->
		<% ElseIf Template = "tests" Then %>
		<!-- #include file="templates/tests.tem" -->
		<% ElseIf Template = "medicine_dose" Then %>
		<!-- #include file="templates/medicine_dose.tem" -->
		<% ElseIf Template = "medicine_dose_package" Then %>
		<!-- #include file="templates/medicine_dose_package.tem" -->
		<% ElseIf Template = "medicine" Then %>
		<!-- #include file="templates/medicine.tem" -->
		<% ElseIf Template = "sugar_report" Then %>
		<!-- #include file="templates/sugar_report.tem" -->
		<% ElseIf Template = "sugar" Then %>
		<!-- #include file="templates/sugar.tem" -->
		<% ElseIf Template = "blood_pressure" Then %>
		<!-- #include file="templates/blood_pressure.tem" -->
		<% ElseIf Template = "insulin" Then %>
		<!-- #include file="templates/insulin.tem" -->
		<% ElseIf Template = "unit" Then %>
		<!-- #include file="templates/unit.tem" -->
		<% ElseIf Template = "weight" Then %>
		<!-- #include file="templates/weight.tem" -->
		<% ElseIf Template = "reports" Then %>
		<!-- #include file="templates/reports.tem" -->
		<% ElseIf Template = "doctor" Then %>
		<!-- #include file="templates/doctor.tem" -->
		<% ElseIf Template = "pharmacy" Then %>
		<!-- #include file="templates/pharmacy.tem" -->
		<% ElseIf Template = "export" Then %>
		<!-- #include file="templates/export.tem" -->
		<% ElseIf Template = "medicinerefill" Then %>
		<!-- #include file="templates/medicinerefill.tem" -->
		<% ElseIf Template = "hospital" Then %>
		<!-- #include file="templates/hospital.tem" -->
		<% ElseIf Template = "hospitalposition" Then %>
		<!-- #include file="templates/hospitalposition.tem" -->
		<% ElseIf Template = "hospitalstaff" Then %>
		<!-- #include file="templates/hospitalstaff.tem" -->
		<% ElseIf Template = "medicine_last_100" Then %>
		<!-- #include file="templates/medicine_last_100.tem" -->
		<% End If %>
	</td>
	<!-- 
	***************************
	HEALTH RIGHT ICONS
	***************************
	 -->
	<% If Template <> "" Then %>
	<td width="100" valign="top">
		<!-- #include virtual="/health/templates/home_sm.tem" -->
	</td>
	<% End If %>
</tr>
</table>


<!-- #include virtual="/includes/debug.inc" -->
<!-- #include virtual="/includes/jquery.inc" -->
<!-- #include virtual="/includes/close_header.inc" -->
<!-- #include virtual="/includes/close_connection.inc" -->
