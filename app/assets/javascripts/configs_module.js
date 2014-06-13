var m = angular.module('configsApp', []);

var ConfigsCtrl = function(initialData) {
  this.workflows = initialData.workflows;
  this.questions = initialData.workflows;
  this.workflowDrivers = initialData.workflows;

  this.getWorkflowFromDriver = function(driver) {
  }

  this.getQuestionFromDriver = function(driver) {
  }
};

m.controller("ConfigsCtrl", [
  "initialData",
  ConfigsCtrl
]);
