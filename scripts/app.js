(function() {
  'use strict';
  angular.module('cycleApp', ['ui.bootstrap']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      }).otherwise({
        redirectTo: '/'
      });
    }
  ]);

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/