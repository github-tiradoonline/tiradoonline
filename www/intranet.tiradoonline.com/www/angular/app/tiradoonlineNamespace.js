var tiradoonlineNamespace = angular.module("tiradoonlineNamespace", ["ngRoute", "ngCookies"])

tiradoonlineNamespace.run
(
	function($rootScope) 
	{
    	$rootScope.loggedIn = false;
	}
)

tiradoonlineNamespace.config
(
	function($routeProvider)
	{
		$routeProvider
			.when('/',
			{
				templateUrl: '/angular/views/login/login.html',
				controller: 'loginController'
			})
			.when('/home',
			{
				templateUrl: '/angular/views/home/home.html',
				controller: 'homeController'
			})
			.when('/sugar',
			{
				templateUrl: '/angular/views/health/sugar.html',
				controller: 'healthController'
			})
			.otherwise(
			{
				redirectTo: '/'
			});

		/* TOASTER OPTIONS */
		toastr.clear();
		toastr.options = 
		{
	   		"closeButton": false,
  			"debug": false,
			"newestOnTop": true,
	  		"progressBar": false,
  			"positionClass": "toast-bottom-right",
 			"preventDuplicates": true,
	  		"onclick": null,
 			"showDuration": "300",
  			"hideDuration": "1000",
	 		"timeOut": "5000",
 			"extendedTimeOut": "1000",
 			"showEasing": "swing",
	  		"hideEasing": "linear",
  			"showMethod": "fadeIn",
  			"hideMethod": "fadeOut"
		};
	}
)

