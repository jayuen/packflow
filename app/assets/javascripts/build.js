var buildApp = angular.module('build', []);

buildApp.factory('documentGenerator', function($http) {
  return {
    build: function(questionsWithAnswers) {
      $http({method: 'GET', url: '/build/workflow_document'})
    }
  }
})

buildApp.controller('BuildCtrl', ['$scope', 'documentGenerator', function($scope, documentGenerator) {
  $scope.questions = BuildData.questions

  $scope.submit = function(){
    documentGenerator.build($scope.questions)
  }
}]);

