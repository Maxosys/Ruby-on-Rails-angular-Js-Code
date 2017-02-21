var app = angular.module('BankApp', ['ngRoute']);

app.config(function ($routeProvider) { 
  $routeProvider 
    .when('/deposite', { 
      controller: 'HomeController', 
      templateUrl: 'views/home.html' 
    })  
});


app.controller('submitbankfrmController', ['$scope','$http',
function($scope,$http){  

  $scope.submitbankfrm = function() {
     

          var parameters = {
                 
                 name: $scope.name
            };
            
              //JSON.parse('[{"x": 1, "y": 0}, {"x":2, "y":5, "marker": {"fillColor":"red"}}, {"x":3, "y":8}]');
            
            var config = {
                params: parameters,
                headers: {'X-CSRF-Token': $('meta[name="csrf-token"]')}               
            };

            $http.post("/getvalid",config)
              .success(function (response) 
              {        
                  var msg = "";



              })
              .catch(function (err) {
              // Log error somehow.
              })
              .finally(function () {
            
              });

  }

}]);

app.controller('GetcurrentbalanceController', ['$scope','$http','$window',
function($scope,$http,$window){  

// check process

    $scope.getcurrentbalanceFunction = function (username) {   

      var parameters = {
                 
                 username: username
            };
            
              //JSON.parse('[{"x": 1, "y": 0}, {"x":2, "y":5, "marker": {"fillColor":"red"}}, {"x":3, "y":8}]');
            
            var config = {
                params: parameters,
                headers: {'X-CSRF-Token': $('meta[name="csrf-token"]')}               
            };

            $http.post("/getcurrentbalance",config)
              .success(function (response) 
              {        
                   $window.alert("Your Current Balance is "+response );
              })
              .catch(function (err) {
              // Log error somehow.
              })
              .finally(function () {
            
              });

    };
}]);
