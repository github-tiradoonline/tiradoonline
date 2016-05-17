<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html ng-app="tiradoonlineNamespace">
<head>
	<meta charset="UTF-8">
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="icon" type="image/ico" href="/images/icons/logo.ico" /> 
	<link rel="shortcut icon" href="/images/icons/logo.ico" />
	<title><%= Application("ApplicationName") %></title>

	
	<!-- JQUERY -->
	<script src="/includes/jquery/jquery.min.js"></script>

	<!-- FACEBOOK -->
	<!-- <script src="/includes/js/facebook.js"></script> -->

	<!-- ANGULAR -->
	<script src="/includes/angular/angular.js"></script>
	<script src="/includes/angular/angular-route.js"></script>
	<script src="/includes/angular/angular-cookies.js"></script>
	<script src="/angular/app/tiradoonlineNamespace.js"></script>
	<script src="/angular/factories/session.js"></script>
	<script src="/angular/factories/cookies.js"></script>
	
	<script src="/angular/controllers/loginController.js"></script>
	<script src="/angular/controllers/navigationController.js"></script>
	<script src="/angular/controllers/homeController.js"></script>

	<!-- BOOTSTRAP -->
	<script src="/includes/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/includes/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/includes/bootstrap/css/bootstrap-theme.min.css">

	<!-- TOASTR -->
	<script src="/includes/toastr/toastr.js"></script>
	<link rel="stylesheet" href="/includes/toastr/toastr.css">
	
	
	
	<style type="text/css">

		body {
			font-family : Cambria;
			padding: 0px;
			margin: 0px;
    		background-repeat: no-repeat;
	    	background-attachment: fixed;
	    	background-position: center; 
			background-image: url('/images/background/logo.gif');	
			/*background-size: 90% 90%;*/
		}

		.ErrorMessage {
			font-weight: bold;
			color: #ff0000;
		}
		
		.modal {
		  text-align: center;
		  padding: 0!important;
		}

		.modal:before {
		  content: '';
		  display: inline-block;
		  height: 100%;
		  vertical-align: middle;
		  margin-right: -4px; /* Adjusts for spacing */
		}	

		.modal-dialog {
		  display: inline-block;
		  text-align: left;
		  vertical-align: middle;
		}
		
	</style>
	
</head>

<body>

	<div ng-if="$root.loggedIn">
		<div ng-include src="'/angular/includes/navigation.html'"></div>
	</div>
	
	
	<div ng-view id="bodyContainer" name="bodyContainer"></div>


</body>
</html>
