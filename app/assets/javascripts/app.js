var app = angular.module('nApp', ['ngRoute']);

$(document).on('turbolinks:load', function(){
    angular.bootstrap (document.body, ['nApp']);
});

var bootStrap = function(){
    angular.bootstrap (document.body, ['nApp']);
}

$(document).ready(function($) {

  if (window.history && window.history.pushState) {

    $(window).on('popstate', function() {
        window.location.reload()
    });

  }
});

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
app.factory("productFactory", function($http){
    var factory = {};
    factory.index = function(callback) {
        $http.get("/productsNg").success(function(output){
            callback(output);
        })
    }
    return factory;
})
app.factory("allProductFactory", function($http){
    var factory = {};
    factory.index = function(callback) {
        $http.get("/productsAll").success(function(output){
            callback(output);
        })
    }
    return factory;
})
app.factory("qProductFactory", function($http){
    var factory = {};
    factory.index = function(callback) {
        $http.get("/qProductAng").success(function(output){
            callback(output);
        })
    }
    return factory;
})
app.controller("qProdController", function($rootScope, qProductFactory){
    qProductFactory.index(function(json){
        $rootScope.products = json;
    })
})
app.controller("catsController", function($rootScope, catFactory){
    catFactory.index(function(json){
        $rootScope.cats = json;
    })
})
app.controller("productsController", function($rootScope, productFactory){
    productFactory.index(function(json){
        $rootScope.products = json;
    })
})
app.controller("allProductsController", function($rootScope, allProductFactory){
    allProductFactory.index(function(json){
        $rootScope.products = json;
    })
})