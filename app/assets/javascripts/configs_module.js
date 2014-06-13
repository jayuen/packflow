var m = angular.module('configsApp', []);

var ConfigsCtrl = function($http, initialData) {
  this.workflows = initialData.workflows;
  this.questions = initialData.questions;
  this.workflowDrivers = initialData.workflow_drivers;
  this.newWorkflow = {};
  this.newQuestion = {};

  this.getWorkflowFromDriver = function(driver) {
    return _.findWhere(this.workflows, { id: driver.workflow_id });
  };

  this.getQuestionFromDriver = function(driver) {
    return _.findWhere(this.questions, { id: driver.question_id });
  };

  this.addNewWorkflow = function() {
    $http.post("/configs/add_new_workflow", this.newWorkflow).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.workflows.push(xhr.data);
      this.resetNewWorkflow();
    }
  };

  this.resetNewWorkflow = function() {
    this.newWorkflow = {};
  };

  this.addNewQuestion = function() {
    $http.post("/configs/add_new_question", this.newQuestion).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.questions.push(xhr.data);
      this.resetNewQuestion();
    }
  };

  this.resetNewQuestion = function() {
    this.newQuestion = {};
  };
};

m.controller("ConfigsCtrl", [
  "$http",
  "initialData",
  ConfigsCtrl
]);
