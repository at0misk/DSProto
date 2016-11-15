var app = angular.module('nApp', ['ngRoute']);
app.config(function($routeProvider) {
    $routeProvider
        .when("/catsPartial", {
            templateUrl: "/catsPartial1.html",
            controller: "catsController"
        })
});
app.factory("catFactory", function($http){
    var factory = {};
    factory.index = function(callback) {
        $http.get("/cats").success(function(output){
            callback(output);
        })
    }
    return factory;
})
app.controller("catsController", function($rootScope, catFactory){
    catFactory.index(function(json){
        $rootScope.cats = json;
    })
})