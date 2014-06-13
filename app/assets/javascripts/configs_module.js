var m = angular.module('configsApp', []);

var ConfigsCtrl = function(initialData) {
  this.workflows = initialData.workflows;
  this.questions = initialData.questions;
  this.workflowDrivers = initialData.workflow_drivers;

  this.getWorkflowFromDriver = function(driver) {
    return _.findWhere(this.workflows, { id: driver.workflow_id });
  }

  this.getQuestionFromDriver = function(driver) {
    return _.findWhere(this.questions, { id: driver.question_id });
  }
};

m.controller("ConfigsCtrl", [
  "initialData",
  ConfigsCtrl
]);
