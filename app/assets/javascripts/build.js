var buildApp = angular.module('build', []);

buildApp.factory('workflowBuilder', function($http) {
  return {
    build: function(questionsWithAnswers) {
      $http({method: 'GET', url: '/build/workflow_document'})
    }
  }
})

buildApp.controller('BuildCtrl', ['$scope', 'workflowBuilder', function($scope, workflowBuilder) {
  $scope.questions = BuildData.questions

  $scope.submit = function(){
    workflowBuilder.build($scope.questions)
  }
}]);

