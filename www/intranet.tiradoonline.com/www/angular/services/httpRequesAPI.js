tiradoonlineNamespace.service('ApiCall', ['$http', 
	function($http)
	{
		var serviceResult;
		
		this.GetApiCall = 
			function(controllerName, methodName)
			{
				serviceResult = $http.get('api/' + controllerName + '/' + methodName)
					.success
					(
						function(data, status)
						{
							serviceResult = (data);
						}
					)
					.error
					(
						function()
						{
							alert("Something went wrong");
						}
					);
				
				return serviceResult;
			};
			
		this.PostApiCall =
			function(controllerName, methodName, obj)
			{
				serviceResult = $http.post('api/' + controllerName + '/' + methodName, obj)
					.success
					(
						function(data, status)
						{
							serviceResult = (data);
						}
					)
					.error
					(
						function()
						{
							alert("Something went wrong");
						}
					);
				
				return serviceResult;
			};
	}
]);