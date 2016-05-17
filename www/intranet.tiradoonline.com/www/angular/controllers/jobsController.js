tiradoonlineNamespace.controller
(
	'jobsController', function($scope, $http)
	{
		$scope.CreateOutlookContact = 
			function()
			{
				var request = $http({
                    	method: "post",
                    	url: "process.cfm",
                    	transformRequest: transformRequestAsFormPost,
                    	data: {
                        	id: 4,
	                        name: "Kim",
    	                    status: "Best Friend"
        	            }
                });
            
			    // Store the data-dump of the FORM scope.
                request.success(
                    function( html ) {
                        alert(html);
                    }
                );			
			}
	}
);