
angular.module 'xsdedit', [
  'ui.router']

.config ($stateProvider, $urlRouterProvider) ->

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state 'index',
      url: "/",
      templateUrl: "templates/index.html"

    .state 'xsd',
      url: "/xsd",
      templateUrl: "templates/xsd.html"

    .state 'schema',
      url: "/schema",
      templateUrl: "templates/schema.html"