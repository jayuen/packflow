var buildApp = angular.module('build', []);

buildApp.controller('BuildCtrl', ['$scope', function($scope) {
  $scope.questions = BuildData.questions
}]);

