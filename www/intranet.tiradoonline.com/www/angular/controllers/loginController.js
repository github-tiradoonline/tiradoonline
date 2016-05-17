tiradoonlineNamespace.controller
(
	'loginController', function($scope, $http, $location, $rootScope)
	{
		$scope.SQL = null;
		$scope.ErrorMessage = "Enter login credentials.";

   		$scope.ValidateLogin = function($rootScope)
		{
			//var url = "/scripts/administration/sql.asp?sql=sp_users_username_password '" + SQLEncode($scope.Username) + "', '" + SQLEncode($scope.Password) + "'";
			var url = "/scripts/administration/sql.asp?sql=" + encodeURIComponent("sp_users_username_password '" + $scope.Username + "', '" + $scope.Password + "'");
			//debugger;
			//alert(url);
            $http.get(url).success
			( 
				function(response) 
				{
					if(response.length > 0)
					{
						//alert("Valid Login");
						//$("#ErrorMessage").html("Valid Login");
						//$("#ErrorMessage").html("Valid Login");
						$scope.SQL = response;
    					//$rootScope.loggedIn = true;
						var redirectURL = "/scripts/login/ValidateLogin.asp?UserName=" + $scope.Username + "&Password=" + $scope.Password;
						location.href = redirectURL
						//$location.path('/home');
					}
					else
					{
						toastr.error('Invalid Login');
						$scope.SQL = "";
						$scope.ErrorMessage = "Invalid Login";
						
					}
            	}
			);
			

		}
		
		//$scope.ValidateLogin();
	}
);