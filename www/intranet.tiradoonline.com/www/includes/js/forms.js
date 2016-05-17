<script type="text/javascript">

function formBankingMonthlyExpenseCreate()
{
	var $BankingMonthlyExpense_Name = $.trim($('#BankingMonthlyExpense_Name').val());

	if($BankingMonthlyExpense_Name == '') {
		displayError($('#BankingMonthlyExpense_Name'));
		$('#BankingMonthlyExpense_Name').focus();
	}
	else
		location.href='<%= SCRIPT_NAME %>?Template=MonthlyExpenses&Action=Add&BankingMonthlyExpenseName=' + encodeURIComponent($BankingMonthlyExpense_Name);
		
}

function formCollectionAgencyCreate()
{
	var $CollectionAgency_Name = $.trim($('#CollectionAgency_Name').val());

	if($CollectionAgency_Name == '') {
		displayError($('#CollectionAgency_Name'));
		$('#CollectionAgency_Name').focus();
	}
	else
		location.href='<%= SCRIPT_NAME %>?Template=Collection&Action=Add&CollectionAgencyName=' + encodeURIComponent($CollectionAgency_Name);
}

function formCreditCardCreate()
{
	var $CreditCard_Name = $.trim($('#CreditCard_Name').val());

	if($CreditCard_Name == '') {
		displayError($('#CreditCard_Name'));
		$('#CreditCard_Name').focus();
	}
	else
		location.href='<%= SCRIPT_NAME %>?Template=CreditCards&Action=Add&CreditCardName=' + encodeURIComponent($CreditCard_Name);
}

function formRemindersCreate()
{
	var $Reminder_Name = $.trim($('#Reminder_Name').val());

	if($Reminder_Name == '') {
		displayError($('#Reminder_Name'));
		$('#Reminder_Name').focus();
	}
	else
		location.href='<%= SCRIPT_NAME %>?Template=Reminders&Action=Add&ReminderName=' + encodeURIComponent($Reminder_Name);
}

function formServerProjectCreate()
{
	var $ServerProject_Name = $.trim($('#ServerProject_Name').val());
	var $ServerProject_Notes = $.trim($('#ServerProject_Notes').val());

	if($ServerProject_Name == '') {
		displayError($('#ServerProject_Name'));
		$('#ServerProject_Name').focus();
	}
	else
		location.href='<%= SCRIPT_NAME %>?SubmitButton=CreateServerProject&ServerProjectName=' + encodeURIComponent($ServerProject_Name) + '&ServerProjectNotes=' + encodeURIComponent($ServerProject_Notes);
}

function formTest(thisForm)
{
	var $TestDate = $(thisForm).TestDate.val();
	alert($TestDate);
	return false;

	//if(!isDate($TestDate)) {
	//	displayError($('#CreditCard_Name'));
	//	$('#CreditCard_Name').focus();
	//}
		
}

$(document).ready(
	function () {		

		$('#formAdministrationIndex').submit(
			function() {
				var $TableName = $.trim($('#TableName').val());
				var $IndexColumns = $.trim($('#IndexColumns').val());

				if($TableName == '') {
					displayError($('#TableName'));
					$('#TableName').focus();
					return false;
				}
				else if($IndexColumns == '') {
					displayError($('#IndexColumns'));
					$('#IndexColumns').focus();
					return false;
				}
			}
		);

		$('#formBankingAccountCreate').submit(
			function() {
				var $BankingAccountName = $.trim($('#BankingAccountName').val());

				if($BankingAccountName == '') {
					displayError($('#BankingAccountName'));
					$('#BankingAccountName').focus();
					return false;
				}
			}
		);
		
		$('#formBanking').submit(
			function() {
				var $BankingDate = $.trim($('#BankingDate').val());
				var $Payment = $.trim($('#Payment').val());

				if(!isDate($BankingDate)) {
					displayError($('#BankingDate'));
					$('#BankingDate').focus();
					return false;
				}
				else if($Payment == '' || isNaNumber($Payment)) {
					displayError($('#Payment'));
					$('#Payment').focus();
					return false;
				}
			}
		);

		$('#formBankingMonthlyExpense').submit(
			function() {
				var $BankingMonthlyExpenseName = $.trim($('#BankingMonthlyExpenseName').val());
				var $BankingMonthlyExpenseAmount = $.trim($('#BankingMonthlyExpenseAmount').val());

				if($BankingMonthlyExpenseName == '') {
					displayError($('#BankingMonthlyExpenseName'));
					$('#BankingMonthlyExpenseName').focus();
					return false;
				}
				else if(isNaNumber($BankingMonthlyExpenseAmount)) {
					displayError($('#BankingMonthlyExpenseAmount'));
					$('#BankingMonthlyExpenseAmount').focus();
					return false;
				}
			}
		);
		
		$('#formBankingSearch').submit(
			function()
			{
				var $searchBankingAccountStartDate = $.trim($('#searchBankingAccountStartDate').val());
				var $searchBankingAccountEndDate = $.trim($('#searchBankingAccountEndDate').val());
				var $boolBankingAccountStartDate = false;
				var $boolBankingAccountEndDate = false;

				if($searchBankingAccountStartDate != '' || $searchBankingAccountEndDate != '')
				{
					if($searchBankingAccountStartDate != '')
					{
						if(!isDate($searchBankingAccountStartDate)) {
							displayError($('#searchBankingAccountStartDate'));
							$('#searchBankingAccountStartDate').focus();
							return false;
						}
						else
							$boolBankingAccountStartDate = true;
					}
	
					if($searchBankingAccountEndDate != '')
					{
						if(!isDate($searchBankingAccountEndDate)) {
							displayError($('#searchBankingAccountEndDate'));
							$('#searchBankingAccountEndDate').focus();
							return false;
						}
						else
							$boolBankingAccountEndDate = true;
					}
					
					if($boolBankingAccountEndDate == true && $searchBankingAccountStartDate == '')
					{
						displayError($('#searchBankingAccountStartDate'));
						$('#searchBankingAccountStartDate').focus();
						return false;
					}
					
					if($boolBankingAccountStartDate == true && $searchBankingAccountEndDate == '')
					{
						displayError($('#searchBankingAccountEndDate'));
						$('#searchBankingAccountEndDate').focus();
						return false;
					}
					
					if($searchBankingAccountStartDate == true && $boolBankingAccountEndDate == '')
					{
						displayError($('#searchBankingAccountStartDate'));
						$('#searchBankingAccountStartDate').focus();
						return false;
					}
					
					if($boolBankingAccountStartDate == true && $boolBankingAccountEndDate == true)
					{
						if($searchBankingAccountEndDate < $searchBankingAccountStartDate)
						{
							alert('Date Range:  End Date cannont be prior to Start Date');
							$('#searchBankingAccountStartDate').val('');
							$('#searchBankingAccountEndDate').val('');
							return false;
						}
					}
				}				

			}
		);
		
		$('#formBankingTransactions').submit(
			function() {
				var $TransactionName = $.trim($('#TransactionName').val());

				if($TransactionName == '') {
					displayError($('#TransactionName'));
					$('#TransactionName').focus();
					return false;
				}
			}
		);
		
		$('#formBloodPressure').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $BloodPressureDate = $.trim($('#BloodPressureDate').val());
				var $BloodPressureTime = $.trim($('#BloodPressureTime').val());
				var $BloodPressureTop = $.trim($('#BloodPressureTop').val());
				var $BloodPressureBottom = $.trim($('#BloodPressureBottom').val());

				if(!isDate($BloodPressureDate)) {
					displayError($('#BloodPressureDate'));
					$('#BloodPressureDate').focus();
					return false;
				}
				else if(!isTime($BloodPressureTime)) {
					displayError($('#BloodPressureTime'));
					$('#BloodPressureTime').focus();
					return false;
				}
				else if(isNaNumber($BloodPressureTop)) {
					displayError($('#BloodPressureTop'));
					$('#BloodPressureTop').focus();
					return false;
				}
				else if(isNaNumber($BloodPressureBottom)) {
					displayError($('#BloodPressureBottom'));
					$('#BloodPressureBottom').focus();
					return false;
				}
			}
		);
		
		$('#formCC').submit(
			function() {
				<% For x = 1 to 5 %>
				var $CC<%= x %> = $.trim($('#CC<%= x %>').val());
				<% Next %>

				<% For x = 1 to 5 %>
				if($CC<%= x %> != '') {
					if(!isEmail($CC<%= x %>)) {
						displayError($('#CC<%= x %>'));
						$('#CC<%= x %>').focus();
						return false;
					}
				}
				<% Next %>
			}
		);
		
		$('#formCollectionAgency').submit(
			function() {
				var $CollectionAgencyName = $.trim($('#CollectionAgencyName').val());
				var $CollectionAgencyAddress1 = $.trim($('#CollectionAgencyAddress1').val());
				var $CollectionAgencyCity = $.trim($('#CollectionAgencyCity').val());
				var $CollectionAgencyZipCode = $.trim($('#CollectionAgencyZipCode').val());
				
				if($CollectionAgencyName == '') {
					displayError($('#CollectionAgencyName'));
					$('#CollectionAgencyName').focus();
					return false;
				}
				else if($CollectionAgencyAddress1 == '') {
					displayError($('#CollectionAgencyAddress1'));
					$('#CollectionAgencyAddress1').focus();
					return false;
				}
				else if($CollectionAgencyCity == '') {
					displayError($('#CollectionAgencyCity'));
					$('#CollectionAgencyCity').focus();
					return false;
				}
				else if($CollectionAgencyZipCode == '') {
					displayError($('#CollectionAgencyZipCode'));
					$('#CollectionAgencyZipCode').focus();
					return false;
				}
			}
		);
		
		$('#formCollectionAgencyPayment').submit(
			function() {
				var $CollectionCreditor = $.trim($('#CollectionCreditor').val());
				var $CollectionStatementDate = $.trim($('#CollectionStatementDate').val());
				var $CollectionNumber = $.trim($('#CollectionNumber').val());
				var $CollectionAmount = $.trim($('#CollectionAmount').val());
				
				if($CollectionCreditor == '') {
					displayError($('#CollectionCreditor'));
					$('#CollectionAgencyZipCode').focus();
					return false;
				}
				else if($CollectionStatementDate == '')
				{
					displayError($('#CollectionStatementDate'));
					$('#CollectionStatementDate').focus();
					return false;
				}
				else if(!isDate($CollectionStatementDate))
				{
					displayError($('#CollectionStatementDate'));
					$('#CollectionStatementDate').focus();
					return false;
				}
				else if($CollectionNumber == '') {
					displayError($('#CollectionNumber'));
					$('#CollectionNumber').focus();
					return false;
				}
				else if(isNaNumber($CollectionAmount)) {
					displayError($('#CollectionAmount'));
					$('#CollectionAmount').focus();
					return false;
				}
			}
		);
		
		$('#formContacts').submit(
			function() {
				var $FileAs = $.trim($('#FileAs').val());
				var $Email1Address = $.trim($('#Email1Address').val());
				var $Email2Address = $.trim($('#Email2Address').val());
				var $Email3Address = $.trim($('#Email3Address').val());
				
				if($FileAs == '') {
					displayError($('#FileAs'));
					$('#tabs').tabs('select', 0);
					$('#FileAs').focus();
					return false;
				}
				else if($Email1Address != '') {
					if(!isEmail($Email1Address))
					{
						displayError($('#Email1Address'));
						$('#tabs').tabs('select', 1);
						$('#Email1Address').focus();
						return false;
					}
				}
				else if($Email2Address != '') {
					if(!isEmail($Email2Address))
					{
						displayError($('#Email2Address'));
						$('#tabs').tabs('select', 1);
						$('#Email2Address').focus();
						return false;
					}
				}
				else if($Email3Address != '') {
					if(!isEmail($Email3Address))
					{
						displayError($('#Email3Address'));
						$('#tabs').tabs('select', 1);
						$('#Email3Address').focus();
						return false;
					}
				}

			}
		);
		
		$('#formContactsSearch').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $SearchString = $.trim($('#SearchString').val());

				if($SearchString == '') {
					$('#SearchString').focus();
					displayError($('#SearchString'));
					return false;
				}
			}
		);

		$('#formCreateAccount').submit(
			function() {
				var $username = $.trim($('#CreateAccountUserName').val());
				var $password = $.trim($('#CreateAccountPassword').val());
				var $confirmpassword = $.trim($('#CreateAccountConfirmPassword').val());
				var $firstname = $.trim($('#CreateAccountFirstName').val());
				var $lastname = $.trim($('#CreateAccountLastName').val());
				var $email = $.trim($('#CreateAccount_Email').val());
				var $mobileemail = $.trim($('#MobileEmail').val());
	
				var $usernameExists = false;
				for ( var i = 0; i < usernameArray.length; i = i + 1 )
				{
					if(usernameArray[i].toUpperCase() == $username.toUpperCase())
						$usernameExists = true;
				}

				var $emailExists = false;
				for ( var i = 0; i < emailArray.length; i = i + 1 )
				{
					if(emailArray[i].toUpperCase() == $email.toUpperCase())
						$emailExists = true;
				}

				
				if($username == '') {
					displayError($('#CreateAccountUserName'));
					$('#CreateAccountUserName').focus();
					return false;
				}
				else if ($usernameExists) {
					displayError($('#CreateAccountUserName'));
					$('#CreateAccountUserName').val('');
					$('#CreateAccountUserName').focus();
					return false;
					
				}
				else if($password == '') {
					displayError($('#CreateAccountPassword'));
					$('#CreateAccountPassword').focus();
					return false;
				}
				else if($password != $confirmpassword) {
					displayError($('#CreateAccountPassword'));
					$('#CreateAccountPassword').val("");
					$('#CreateAccountConfirmPassword').val("");
					$('#CreateAccountPassword').focus();
					return false;
				}
				else if($firstname == '') {
					displayError($('#CreateAccountFirstName'));
					$('#CreateAccountFirstName').focus();
					return false;
				}
				else if($lastname == '') {
					displayError($('#CreateAccountLastName'));
					$('#CreateAccountLastName').focus();
					return false;
				}
				else if(!isEmail($email)) {
					displayError($('#CreateAccount_Email'));
					$('#CreateAccount_Email').focus();
					return false;
				}
				else if ($emailExists) {
					displayError($('#CreateAccount_Email'));
					$('#CreateAccount_Email').val('');
					$('#CreateAccount_Email').focus();
					return false;
				}
				else if ($mobileemail == '')
				{
					if(!isEmail($mobileemail)) {
						displayError($('#MobileEmail'));
						$('#MobileEmail').focus();
						return false;
					}
				}
				
				//return false;
			}
		);

		$('#formCreditCard').submit(
			function() {
				var $CreditCardName = $.trim($('#CreditCardName').val());
				var $CreditLimit = $.trim($('#CreditLimit').val());
				var $MinimumPayment = $.trim($('#MinimumPayment').val());
				var $CreditAvailable = $.trim($('#CreditAvailable').val());
				var $DueDate = $.trim($('#DueDate').val());
				var $ClosingDate = $.trim($('#ClosingDate').val());
				var $Percentage = $.trim($('#Percentage').val());

				if($CreditCardName == '') {
					displayError($('#CreditCardName'));
					$('#CreditCardName').focus();
					return false;
				}
				else if(isNaNumber($CreditLimit)) {
					displayError($('#CreditLimit'));
					$('#CreditLimit').focus();
					return false;
				}
				else if(isNaNumber($MinimumPayment)) {
					displayError($('#MinimumPayment'));
					$('#MinimumPayment').focus();
					return false;
				}
				else if(isNaNumber($CreditAvailable)) {
					displayError($('#CreditAvailable'));
					$('#CreditAvailable').focus();
					return false;
				}
				else if(isNaNumber($Percentage)) {
					displayError($('#Percentage'));
					$('#Percentage').focus();
					return false;
				}
			}
		);
		
		$('#formCreditCardPayment').submit(
			function() {
				var $CreditCardPaymentDate = $.trim($('#CreditCardPaymentDate').val());
				var $CreditCardPaymentAmount = $.trim($('#CreditCardPaymentAmount').val());

				if(!isDate($CreditCardPaymentDate)) {
					displayError($('#CreditCardPaymentDate'));
					$('#CreditCardPaymentDate').focus();
					return false;
				}
				else if($CreditCardPaymentAmount == '' || isNaNumber($CreditCardPaymentAmount)) {
					displayError($('#CreditCardPaymentAmount'));
					$('#CreditCardPaymentAmount').focus();
					return false;
				}
			}
		);
		
		$('#formDoctor').submit(
			function() {
				var $LastName = $.trim($('#LastName').val());

				if($LastName == '') {
					displayError($('#LastName'));
					$('#LastName').focus();
					return false;
				}
			}
		);

		$('#formEmailTemplates').submit(
			function() {
				var $CreateAccountSubject = $.trim($('#CreateAccountSubject').val());
				var $CreateAccountEmail = $.trim($('#CreateAccountEmail').val());
				var $ForgotPasswordSubject = $.trim($('#ForgotPasswordSubject').val());
				var $ForgotPasswordEmail = $.trim($('#ForgotPasswordEmail').val());

				if($CreateAccountSubject == '') {
					displayError($('#CreateAccountSubject'));
					$('#CreateAccountSubject').focus();
					$('#tabs').tabs('select', 0);
					return false;
				}
				else if(!isEmail($CreateAccountEmail)) {
					displayError($('#CreateAccountEmail'));
					$('#CreateAccountEmail').focus();
					$('#tabs').tabs('select', 0);
					return false;
				}
				else if($ForgotPasswordSubject == '') {
					displayError($('#ForgotPasswordSubject'));
					$('#ForgotPasswordSubject').focus();
					$('#tabs').tabs('select', 1);
					return false;
				}
				else if(!isEmail($ForgotPasswordEmail)) {
					displayError($('#ForgotPasswordEmail'));
					$('#ForgotPasswordEmail').focus();
					$('#tabs').tabs('select', 1);
					return false;
				}
			}
		);
		
		$('#formExport').submit(
			function() {
				var $HealthStartDate = $.trim($('#HealthStartDate').val());
				var $HealthEndDate = $.trim($('#HealthEndDate').val());

				if($HealthStartDate == '') {
					displayError($('#HealthStartDate'));
					$('#HealthStartDate').focus();
					return false;
				}
				else if($HealthEndDate == '') {
					displayError($('#HealthEndDate'));
					$('#HealthEndDate').focus();
					return false;
				}
			}
		);
		
		$('#formFacebook').submit(
			function() {
				var $LyricName = $.trim($('#LyricName').val());
				var $LyricActorArtist = $.trim($('#LyricActorArtist').val());
				var $LyricContent = $.trim($('#LyricContent').val());

				if($LyricName == '') {
					$('#LyricName').focus();
					displayError($('#LyricName'));
					return false;
				}
				else if($LyricActorArtist == '') {
					$('#LyricActorArtist').focus();
					displayError($('#LyricActorArtist'));
					return false;
				}
				else if($LyricContent == '') {
					$('#LyricContent').focus();
					displayError($('#LyricContent'));
					return false;
				}
                else
                    return true;
			}
		);

		$('#formFilteredBrowser').submit(
			function() {
				var $Alias = $.trim($('#Alias').val());
				var $Browser = $.trim($('#Browser').val());

				if($Alias == '') {
					displayError($('#Alias'));
					$('#Alias').focus();
					return false;
				}
				else if($Browser == '') {
					displayError($('#Browser'));
					$('#Browser').focus();
					return false;
				}
			}
		);

		$('#formFilteredIPAddress').submit(
			function() {
				var $Alias = $.trim($('#Alias').val());
				var $IPAddress = $.trim($('#IPAddress').val());

				if($Alias == '') {
					displayError($('#Alias'));
					$('#Alias').focus();
					return false;
				}
				else if($IPAddress == '') {
					displayError($('#IPAddress'));
					$('#IPAddress').focus();
					return false;
				}
			}
		);

		$('#formForgotPassword').submit(
			function() {
				var $errorMessage = $('#ForgotPasswordErrorMessage');
				var $email = $.trim($('#ForgotPassword_Email').val());
				var $emailExists = false;

				for ( var i = 0; i < emailArray.length; i = i + 1 )
				{
					if(emailArray[i].toUpperCase() == $email.toUpperCase())
						$emailExists = true;
				}

				if(!isEmail($email)) {
					displayError($('#ForgotPassword_Email'));
					$('#ForgotPassword_Email').focus();
					return false;
				}
				else if (!$emailExists) {
					displayError($('#ForgotPassword_Email'));
					$('#ForgotPassword_Email').val('');
					$('#ForgotPassword_Email').focus();
					return false;
				}
			}
		);

		
		$('#formHeartRate').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $HeartRateDate = $.trim($('#HeartRateDate').val());
				var $HeartRateTime = $.trim($('#HeartRateTime').val());
				var $HeartRate = $.trim($('#HeartRate').val());

				if(!isDate($HeartRateDate)) {
					displayError($('#HeartRateDate'));
					$('#HeartRateDate').focus();
					return false;
				}
				else if(!isTime($HeartRateTime)) {
					displayError($('#HeartRateTime'));
					$('#HeartRateTime').focus();
					return false;
				}
				else if(isNaNumber($HeartRate)) {
					displayError($('#HeartRate'));
					$('#HeartRate').focus();
					return false;
				}
			}
		);
		
		$('#formHospital').submit(
			function() {
				var $HospitalName = $.trim($('#HospitalName').val());

				if($HospitalName == '') {
					displayError($('#HospitalName'));
					$('#HospitalName').focus();
					return false;
				}
			}
		);
		
		$('#formHospitalPosition').submit(
			function() {
				var $HospitalPositionName = $.trim($('#HospitalPositionName').val());

				if($HospitalPositionName == '') {
					displayError($('#HospitalPositionName'));
					$('#HospitalPositionName').focus();
					return false;
				}
			}
		);
		
		$('#formHospitalStaff').submit(
			function() {
				var $FirstName = $.trim($('#FirstName').val());
				var $LastName = $.trim($('#LastName').val());

				if($FirstName == '' && $LastName == '') {
					displayError($('#LastName'));
					$('#LastName').focus();
					return false;
				}
			}
		);
		
		$('#formHospitalStaffSearch').submit(
			function() {
				var $HospitalStaffName = $.trim($('#HospitalStaffName').val());

				if($HospitalStaffName == '') {
					displayError($('#HospitalStaffName'));
					$('#HospitalStaffName').focus();
					return false;
				}
			}
		);

		$('#formJobQueueResumeSubmit').submit(
			function() {
				var $JobQueueID = $.trim($('#JobQueueID').val());

				if(!isDate($JobDate)) {
					displayError($('#JobDate'));
					$('#JobDate').focus();
					return false;
				}
			}
		);

		$('#formJobs').submit(
			function() {
				var $JobDate = $.trim($('#JobDate').val());
				var $JobPosition = $.trim($('#JobPosition').val());
				var $JobSalary = $.trim($('#JobSalary').val());

				if(!isDate($JobDate)) {
					displayError($('#JobDate'));
					$('#JobDate').focus();
					return false;
				}
				else if($JobPosition == '') {
					displayError($('#JobPosition'));
					$('#JobPosition').focus();
					return false;
				}
				else if($JobSalary != '') {
						if(isNaNumber($JobSalary)) {
							displayError($('#JobSalary'));
							$('#JobSalary').focus();
							return false;
						}
				}
			}
		);
		
		$('#formJobsCompany').submit(
			function() {
				var $JobCompanyName = $.trim($('#JobCompanyName').val());

				if($JobCompanyName == '') {
					displayError($('#JobCompanyName'));
					$('#JobCompanyName').focus();
					return false;
				}
			}
		);
		
		$('#formJobsCompanies').submit(
			function() {
				var $JobCompanyNameSearch = $.trim($('#JobCompanyNameSearch').val());

				if($JobCompanyNameSearch == '') {
					displayError($('#JobCompanyNameSearch'));
					$('#JobCompanyNameSearch').focus();
					return false;
				}
			}
		);
		
		$('#formJobsCompanyAddress').submit(
			function() {
				var $JobCompanyAddress1 = $.trim($('#JobCompanyAddress1').val());
				var $JobCompanyAddressCity = $.trim($('#JobCompanyAddressCity').val());
				var $JobCompanyAddressZipCode = $.trim($('#JobCompanyAddressZipCode').val());

				if($JobCompanyAddress1 == '') {
					displayError($('#JobCompanyAddress1'));
					$('#JobCompanyAddress1').focus();
					return false;
				}
				else if($JobCompanyAddressCity == '') {
					displayError($('#JobCompanyAddressCity'));
					$('#JobCompanyAddressCity').focus();
					return false;
				}
				else if($JobCompanyAddressZipCode == '') {
					displayError($('#JobCompanyAddressZipCode'));
					$('#JobCompanyAddressZipCode').focus();
					return false;
				}
			}
		);
		
		$('#formJobsCompanyContact').submit(
			function() {
				var $JobCompanyContactFirstName = $.trim($('#JobCompanyContactFirstName').val());
				var $JobCompanyContactLastName = $.trim($('#JobCompanyContactLastName').val());
				var $JobCompanyContactEmail = $.trim($('#JobCompanyContactEmail').val());

				if($JobCompanyContactFirstName == '') {
					displayError($('#JobCompanyContactFirstName'));
					$('#JobCompanyContactFirstName').focus();
					return false;
				}
				/*else if($JobCompanyContactLastName == '') {
					displayError($('#JobCompanyContactLastName'));
					$('#JobCompanyContactLastName').focus();
					return false;
				}*/
				else if($JobCompanyContactEmail != '') {
					if(!isEmail($JobCompanyContactEmail)) {
						displayError($('#JobCompanyContactEmail'));
						$('#JobCompanyContactEmail').focus();
						return false;
					}
				}
			}
		);

		$('#formJobCoverLetter').submit(
			function() {
				var $JobCoverLetterName = $.trim($('#JobCoverLetterName').val());
				var $JobCoverLetterText = $.trim($('#JobCoverLetterText').val());

				if($JobCoverLetterName == '') {
					displayError($('#JobCoverLetterName'));
					$('#JobCoverLetterName').focus();
					return false;
				}
				else if($JobCoverLetterText == '') {
					displayError($('#JobCoverLetterText'));
					$('#JobCoverLetterText').focus();
					return false;
				}
			}
		);

		$('#formJobInterviewType').submit(
			function() {
				var $JobInterviewType = $.trim($('#JobInterviewType').val());

				if($JobInterviewType == '') {
					displayError($('#JobInterviewType'));
					$('#LoginJobInterviewType').focus();
					return false;
				}
			}
		);

		$('#formJobSalaryType').submit(
			function() {
				var $JobSalaryType = $.trim($('#JobSalaryType').val());

				if($JobSalaryType == '') {
					displayError($('#JobSalaryType'));
					$('#LoginJobSalaryType').focus();
					return false;
				}
			}
		);

		$('#formLogin').submit(
			function()
			{
				var $username = $.trim($('#LoginUserName').val());
				var $password = $.trim($('#LoginPassword').val());

				var $loginURL = "/scripts/users/username_password_exists.asp";
				var $validlogin = false;

				if($username == '') {
					displayError($('#LoginUserName'));
					$('#LoginUserName').focus();
					return false;
				}
				else if($password == '') {
					displayError($('#LoginPassword'));
					$('#LoginPassword').focus();
					return false;
				}
				else
				{
					$.ajax
					(
						{
							url: $loginURL, 
							data:
								{
									UserName : $username,
									Password : $password
								},
							async: false,
							success: 	
								function(result)
								{
									if(result == "0")
									{
										alert("Invalid Login");
										
										$validlogin = false;
									}
									else
										$validlogin = true;
    							}
						}
							
					);
				}
				
				return $validlogin;
			}
		);

		$('#formLogin2').submit(
			function()
			{
				var $errorMessage = $('#LoginErrorMessage');
				var $username = $.trim($('#LoginUserName').val());
				var $password = $.trim($('#LoginPassword').val());

				var $loginURL = "/scripts/users/username_password_exists.asp?Username=" + escape($username) + "&password=" + escape($password);
				var $userExists = false;

				$.get( $loginURL, 
					function( $user_Exists ) 
					{
						if($.trim($user_Exists) == "1")
							$userExists = true;
					}
				) 	
				.done
				(
					function() 
					{
						
						if($username == '') {
							displayError($('#LoginUserName'));
							$('#LoginUserName').focus();
							return false;
						}
						else if($password == '') {
							displayError($('#LoginPassword'));
							$('#LoginPassword').focus();
							return false;
						}
						else if(!$userExists) {
							displayError($('#LoginUserName'));
							$('#LoginUserName').val('');
							$('#LoginUserName').focus();
							$('#LoginPassword').val('');
							return false;
						}
					}
				)
				.fail(
					function() 
					{
						//alert('fail');
					}
				)
				.always(
					function() 
					{
					}
				);
			}
		);

		$('#formMedicine').submit(
			function() {
				var $MedicineName = $.trim($('#MedicineName').val());

				if($MedicineName == '') {
					displayError($('#MedicineName'));
					$('#MedicineName').focus();
					return false;
				}
			}
		);

		$('#formMedicineDose').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $MedicineDate = $.trim($('#MedicineDoseDate').val());
				var $MedicineTime = $.trim($('#MedicineDoseTime').val());
				var $Amount = $.trim($('#Amount').val());

				if(!isDate($MedicineDate)) {
					displayError($('#MedicineDoseDate'));
					$('#MedicineDate').focus();
					return false;
				}
				else if(!isTime($MedicineTime)) {
					displayError($('#MedicineDoseTime'));
					$('#MedicineTime').focus();
					return false;
				}
				else if(isNaNumber($Amount)) {
					displayError($('#Amount'));
					$('#Amount').focus();
					return false;
				}
			}
		);


		$('#formMedicineDosePackage').submit(
			function() {
				/*
				var $MedicineDosePackageName = $.trim($('#MedicineDosePackageName').val());
				alert('test');

				if($MedicineDosePackageName == '') {
					displayError($('#MedicineDosePackageName'));
					$('#MedicineDosePackageName').focus();
					return false;
				}
				*/
				var $errorMessage = $('#HealthErrorMessage');
				var $MedicineDate2 = $.trim($('#MedicineDoseDate2').val());
				var $MedicineTime2 = $.trim($('#MedicineDoseTime2').val());
				var $Amount = $.trim($('#Amount').val());

				if(!isDate($MedicineDate2)) {
					displayError($('#MedicineDoseDate2'));
					$('#MedicineDate2').focus();
					return false;
				}
				else if(!isTime($MedicineTime2)) {
					displayError($('#MedicineDoseTime2'));
					$('#MedicineTime2').focus();
					return false;
				}
			}
		);

		$('#formMedicineRefill').submit(
			function() {
				var $RefillOrderDate = $.trim($('#RefillOrderDate').val());

				if(!isDate($RefillOrderDate)) {
					displayError($('#RefillOrderDate'));
					$('#RefillOrderDate').focus();
					return false;
				}
			}
		);

		$('#formNotes').submit(
			function() {
				var $NoteName = $.trim($('#NoteName').val());
				var $NoteText = $.trim($('#NoteText').val());

				if($NoteName == '') {
					displayError($('#NoteName'));
					$('#NoteName').focus();
					return false;
				}
				else if($NoteText == '') {
					displayError($('#NoteText'));
					$('#NoteText').focus();
					return false;
				}
			}
		);

		
		$('#formOxygen').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $OxygenDate = $.trim($('#OxygenDate').val());
				var $OxygenTime = $.trim($('#OxygenTime').val());
				var $Oxygen = $.trim($('#Oxygen').val());

				if(!isDate($OxygenDate)) {
					displayError($('#OxygenDate'));
					$('#OxygenDate').focus();
					return false;
				}
				else if(!isTime($OxygenTime)) {
					displayError($('#OxygenTime'));
					$('#OxygenTime').focus();
					return false;
				}
				else if(isNaNumber($Oxygen)) {
					displayError($('#Oxygen'));
					$('#Oxygen').focus();
					return false;
				}
			}
		);

		
		$('#formPaycheck').submit(
			function() {
				var $PaycheckDate = $.trim($('#PaycheckDate').val());
				var $HourlyRate = $.trim($('#HourlyRate').val());
				var $Gross = $.trim($('#Gross').val());
				var $Federal = $.trim($('#Federal').val());
				var $SocialSecurity = $.trim($('#SocialSecurity').val());
				var $Medicare = $.trim($('#Medicare').val());
				var $Withholding = $.trim($('#Withholding').val());
				var $Disability = $.trim($('#Disability').val());
				var $Disability = $.trim($('#City').val());

				if(!isDate($PaycheckDate)) {
					displayError($('#PaycheckDate'));
					$('#PaycheckDate').focus();
					return false;
				}
				else if($HourlyRate == '') {
					if(isNaNumber($HourlyRate))
					{
						displayError($('#HourlyRate'));
						$('#HourlyRate').focus();
						return false;
					}
				}
				else if($Gross == '') {
					if(isNaNumber($Gross))
					{
						displayError($('#Gross'));
						$('#Gross').focus();
						return false;
					}
				}
				else if($Federal == '') {
					if(isNaNumber($Federal))
					{
						displayError($('#Federal'));
						$('#Federal').focus();
						return false;
					}
				}
				else if($SocialSecurity == '') {
					if(isNaNumber($SocialSecurity))
					{
						displayError($('#SocialSecurity'));
						$('#SocialSecurity').focus();
						return false;
					}
				}
				else if($Medicare == '') {
					if(isNaNumber($Medicare))
					{
						displayError($('#Medicare'));
						$('#Medicare').focus();
						return false;
					}
				}
				else if($Withholding == '') {
					if(isNaNumber($Withholding))
					{
						displayError($('#Withholding'));
						$('#Withholding').focus();
						return false;
					}
				}
				else if($Disability == '') {
					if(isNaNumber($Disability))
					{
						displayError($('#Disability'));
						$('#Disability').focus();
						return false;
					}
				}
				else if($City == '') {
					if(isNaNumber($City))
					{
						displayError($('#City'));
						$('#City').focus();
						return false;
					}
				}
			}
		);

		$('#formPageLogs').submit(
			function() {
				var $Keyword = $.trim($('#Keyword').val());
				var $SearchDate = $.trim($('#SearchDate').val());

				if($Keyword == '') {
					displayError($('#Keyword'));
					$('#Keyword').focus();
					return false;
				}
				else if(!isDate($SearchDate)) {
					displayError($('#SearchDate'));
					$('#SearchDate').focus();
					return false;
				}
			}
		);

		$('#formPersonalInformation').submit(
			function() {
				var $AccountName = $.trim($('#AccountName').val());
				
				if($AccountName == '') {
					$('#tabs').tabs('select', 0);
					$('#AccountName').focus();
					displayError($('#AccountName'));

					//alert($('#AccountName').className);
					return false;
				}
			}
		);

		$('#formPharmacy').submit(
			function() {
				var $PharmacyName = $.trim($('#PharmacyName').val());

				if($PharmacyName == '') {
					displayError($('#PharmacyName'));
					$('#PharmacyName').focus();
					return false;
				}
			}
		);

		$('#formRecoveryCounselor').submit(
			function() {
				var $LastName = $.trim($('#LastName').val());

				/*if($LastName == '') {
					displayError($('#LastName'));
					$('#LastName').focus();
					return false;
				}*/
			}
		);

		$('#formRecoveryGroup').submit(
			function() {
				var $RecoveryGroupName = $.trim($('#RecoveryGroupName').val());

				if($RecoveryGroupName == '') {
					displayError($('#RecoveryGroupName'));
					$('#RecoveryGroupName').focus();
					return false;
				}
			}
		);

		$('#formRecoveryGroupSession').submit(
			function() {
				var $RecoveryGroupSessionDate = $.trim($('#RecoveryGroupSessionDate').val());
				var $RecoveryGroupSessionTime = $.trim($('#RecoveryGroupSessionTime').val());

				if(!isDate($RecoveryGroupSessionDate)) {
					displayError($('#RecoveryGroupSessionDate'));
					$('#RecoveryGroupSessionDate').focus();
					return false;
				}
				else if(!isTime($RecoveryGroupSessionTime)) {
					displayError($('#RecoveryGroupSessionTime'));
					$('#RecoveryGroupSessionTime').focus();
					return false;
				}
			}
		);

		$('#formRecoveryProgram').submit(
			function() {
				var $ProgramName = $.trim($('#ProgramName').val());
				var $start_dt = $.trim($('#start_dt').val());

				if($ProgramName == '') {
					displayError($('#ProgramName'));
					$('#ProgramName').focus();
					return false;
				}
				else if(!isDate($start_dt)) {
					displayError($('#start_dt'));
					$('#start_dt').focus();
					return false;
				}
			}
		);

		$('#formRecoveryDrugTest').submit(
			function() {
				var $RecoveryDrugTestDateTime = $.trim($('#RecoveryDrugTestDateTime').val());

				if(!isDate($RecoveryDrugTestDateTime)) {
					displayError($('#RecoveryDrugTestDateTime'));
					$('#RecoveryDrugTestDateTime').focus();
					return false;
				}
			}
		);

		$('#formReferencedBy').submit(
			function() {
				var $OrderNum = $.trim($('#OrderNum').val());
				var $ReferencedByName = $.trim($('#ReferencedByName').val());

				if(isNaNumber($OrderNum) || $OrderNum == '') {
					displayError($('#OrderNum'));
					$('#OrderNum').focus();
					return false;
				}
				else if($ReferencedByName == '') {
					displayError($('#ReferencedByName'));
					$('#ReferencedByName').focus();
					return false;
				}
			}
		);

		$('#frmRehabProgram').submit(
			function() {
				var $ProgramName = $.trim($('#ProgramName').val());
				var $StartDate = $.trim($('#StartDate').val());

				if($ProgramName == '') {
					displayError($('#ProgramName'));
					$('#ProgramName').focus();
					return false;
				}
				else if(!isDate($StartDate)) {
					displayError($('#StartDate'));
					$('#StartDate').focus();
					return false;
				}
			}
		);
	
		$('#formReminders').submit(
			function() {
				var $ReminderDate = $.trim($('#ReminderDate').val());
				var $ReminderTime = $.trim($('#ReminderTime').val());
				var $ReminderName = $.trim($('#ReminderName').val());
				
				if(!isDate($ReminderDate)) {
					displayError($('#ReminderDate'));
					$('#ReminderDate').focus();
					return false;
				}
				else if(!isTime($ReminderTime)) {
					displayError($('#ReminderTime'));
					$('#ReminderTime').focus();
					return false;
				}
				else if($ReminderName == '') {
					displayError($('#ReminderName'));
					$('#ReminderName').focus();
					return false;
				}
			}
		);
	
		$('#formResume').submit(
			function() {
				var $ResumeFileName = $.trim($('#ResumeFileName').val());

				if($ResumeFileName == '') {
					displayError($('#ResumeFileName'));
					$('#ResumeFileName').focus();
					return false;
				}
			}
		);
		
		$('#formResumeDownloadType').submit(
			function() {
				var $ResumeDownloadTypeName = $.trim($('#ResumeDownloadTypeName').val());
				var $ResumeDownloadTypeFileName = $.trim($('#ResumeDownloadTypeFileName').val());

				if($ResumeDownloadTypeName == '') {
					$('#ResumeDownloadTypeName').focus();
					displayError($('#ResumeDownloadTypeName'));
					return false;
				}
				else if($ResumeDownloadTypeFileName == '') {
					$('#ResumeDownloadTypeFileName').focus();
					displayError($('#ResumeDownloadTypeFileName'));
					return false;
				}
			}
		);

		$('#formSchema').submit(
			function() {
				var $ObjectText = $.trim($('#ObjectText').val());

				if($ObjectText == '') {
					displayError($('#ObjectText'));
					$('#ObjectText').focus();
					return false;
				}
			}
		);
		
		$('#frmServer').submit(
			function() {
			
				var $ServerName = $.trim($('#ServerName').val());
				
				if($ServerName == '') {
					displayError($('#ServerName'));
					$('#ServerName').focus();
					return false;
				}
			}
		);
		
		$('#frmServerInformation').submit(
			function() {
				var $ServerInformationName = $.trim($('#ServerInformationName').val());
				var $ServerInformationValue = $.trim($('#ServerInformationValue').val());
				
				if($ServerInformationName == '') {
					displayError($('#ServerInformationName'));
					$('#ServerInformationName').focus();
					return false;
				}
				else if($ServerInformationValue == '') {
					displayError($('#ServerInformationValue'));
					$('#ServerInformationValue').focus();
					return false;
				}
			}
		);

		
		$('#frmServerProject').submit(
			function() {
			
				var $ServerProjectName = $.trim($('#ServerProjectName').val());
				
				if($ServerProjectName == '') {
					displayError($('#ServerProjectName'));
					$('#ServerProjectName').focus();
					return false;
				}
			}
		);

		$('#formSnippet').submit(
			function() {
				var $SnippetName = $.trim($('#SnippetName').val());
				var $Snippet = $.trim($('#Snippet').val());

				if($SnippetName == '') {
					displayError($('#SnippetName'));
					$('#SnippetName').focus();
					return false;
				}
				else if($Snippet == '') {
					displayError($('#Snippet'));
					$('#Snippet').focus();
					return false;
				}
			}
		);

		$('#formSQLEditor').submit(
			function() {
				var $sqlStatement = $.trim($('#sqlStatement').val());

				if($sqlStatement == '') {
					displayError($('#sqlStatement'));
					$('#sqlStatement').focus();
					return false;
				}
			}
		);

		$('#formState').submit(
			function() {
				var $State = $.trim($('#State').val());
				var $StateAbbr = $.trim($('#StateAbbr').val());

				if($StateAbbr == '' || $StateAbbr.length > 2) {
					displayError($('#StateAbbr'));
					$('#StateAbbr').focus();
					return false;
				}
				else if($State == '') {
					displayError($('#State'));
					$('#StateAbbr').focus();
					return false;
				}
			}
		);

		$('#formSugar').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $sugarDate = $.trim($('#SugarDate').val());
				var $sugarTime = $.trim($('#SugarTime').val());
				var $Sugar = $.trim($('#Sugar').val());
				
				if(!isDate($sugarDate)) {
					displayError($('#SugarDate'));
					$('#SugarDate').focus();
					return false;
				}
				else if(!isTime($sugarTime)) {
					displayError($('#SugarTime'));
					$('#SugarTime').focus();
					return false;
				}
				else if($Sugar == '') {
					displayError($('#Sugar'));
					$('#Sugar').focus();
					return false;
				}
			}
		);

		$('#formTemperature').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $TemperatureDate = $.trim($('#TemperatureDate').val());
				var $TemperatureTime = $.trim($('#TemperatureTime').val());
				var $Temperature = $.trim($('#Temperature').val());

				if(!isDate($TemperatureDate)) {
					displayError($('#TemperatureDate'));
					$('#TemperatureDate').focus();
					return false;
				}
				else if(!isTime($TemperatureTime)) {
					displayError($('#TemperatureTime'));
					$('#TemperatureTime').focus();
					return false;
				}
				else if(isNaNumber($Temperature)) {
					displayError($('#Temperature'));
					$('#Temperature').focus();
					return false;
				}
			}
		);
		
		function formTestFunction(id)
		{
			var $TestTypeName = $.trim($('#TestTypeName').val());
			$Counter = $('#Counter').val();
				
			if($TestTypeName == '') {
				displayError($('#TestTypeName'));
				$('#TestTypeName').focus();
				return false;
			}
		};

		$('#formTimesheetCompany').submit(
			function() {
				var $TimeSheetCompanyName = $.trim($('#TimeSheetCompanyName').val());
				var $TimeSheetCompanyAddress1 = $.trim($('#TimeSheetCompanyAddress1').val());
				var $TimeSheetCompanyCity = $.trim($('#TimeSheetCompanyCity').val());
				var $TimeSheetCompanyZipCode = $.trim($('#TimeSheetCompanyZipCode').val());

				if($TimeSheetCompanyName == '') {
					displayError($('#TimeSheetCompanyName'));
					$('#TimeSheetCompanyName').focus();
					return false;
				}
				/*
				else if($TimeSheetCompanyAddress1 == '') {
					displayError($('#TimeSheetCompanyAddress1'));
					$('#TimeSheetCompanyAddress1').focus();
					return false;
				}
				else if($TimeSheetCompanyCity == '') {
					displayError($('#TimeSheetCompanyCity'));
					$('#TimeSheetCompanyCity').focus();
					return false;
				}
				else if($TimeSheetCompanyZipCode == '') {
					displayError($('#TimeSheetCompanyZipCode'));
					$('#TimeSheetCompanyZipCode').focus();
					return false;
				}*/
			}
		);
		
		$('#formTimesheet').submit(
			function() {
				var $TimeSheetInvoiceDate = $.trim($('#TimeSheetInvoiceDate').val());
				var $TimeSheetInvoiceNumber = $.trim($('#TimeSheetInvoiceNumber').val());
				var $TimeSheetHourlyRate = $.trim($('#TimeSheetHourlyRate').val());

				if(!isDate($TimeSheetInvoiceDate)) {
					displayError($('#TimeSheetInvoiceDate'));
					$('#TimeSheetInvoiceDate').focus();
					return false;
				}
				else if($TimeSheetInvoiceNumber == '') {
					displayError($('#TimeSheetInvoiceNumber'));
					$('#TimeSheetInvoiceNumber').focus();
					return false;
				}
				else if(isNaNumber($TimeSheetHourlyRate)) {
					displayError($('#TimeSheetHourlyRate'));
					$('#TimeSheetHourlyRate').focus();
					return false;
				}
			}
		);

		$('#formTimesheetDetail').submit(
			function() {
				var $TimesheetHours = $.trim($('#TimesheetHours').val());
				var $TimesheetDescription = $.trim($('#TimesheetDescription').val());
				
				if(isNaNumber($TimesheetHours)) {
					displayError($('#TimesheetHours'));
					$('#TimesheetHours').focus();
					return false;
				}
				else if($TimesheetDescription == '') {
					displayError($('#TimesheetDescription'));
					$('#TimesheetDescription').focus();
					return false;
				}
			}
		);

		$('#formUnit').submit(
			function() {
				var $UnitName = $('#UnitName').val();

				if($UnitName == '') {
					displayError($('#UnitName'));
					$('#UnitName').focus();
					return false;
				}
			}
		);


		$('#formWeight').submit(
			function() {
				var $errorMessage = $('#HealthErrorMessage');
				var $WeightDate = $.trim($('#WeightDate').val());
				var $WeightTime = $.trim($('#WeightTime').val());
				var $Weight = $.trim($('#Weight').val());
				var $WeightLocation = $.trim($('#WeightLocation').val());

				if(!isDate($WeightDate)) {
					displayError($('#WeightDate'));
					$('#WeightDate').focus();
					return false;
				}
				else if(!isTime($WeightTime)) {
					displayError($('#WeightTime'));
					$('#WeightTime').focus();
					return false;
				}
				else if(isNaNumber($Weight)) {
					displayError($('#Weight'));
					$('#Weight').focus();
					return false;
				}
				else if($WeightLocation == '') {
					displayError($('#WeightLocation'));
					$('#WeightLocation').focus();
					return false;
				}
			}
		);


	}
);
	
</script>

