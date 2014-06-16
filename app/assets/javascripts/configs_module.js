var m = angular.module('configsApp', []);

var ConfigsCtrl = function($http, initialData) {
  this.workflows = initialData.workflows;
  this.questions = initialData.questions;
  this.workflowDrivers = initialData.workflow_drivers;
  this.settingDrivers = initialData.setting_drivers;
  this.newWorkflow = {};
  this.newQuestion = {};
  this.newWorkflowDriver = {};
  this.newSettingDriver = {};

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

  this.removeWorkflow = function(workflowToRemove) {
    $http.post("/configs/remove_workflow", workflowToRemove).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.workflows = _.reject(this.workflows, function(workflow) {
        return workflow.id == workflowToRemove.id
      })
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

  this.removeQuestion = function(questionToRemove) {
    $http.post("/configs/remove_question", questionToRemove).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.questions = _.reject(this.questions, function(question) {
        return question.id == questionToRemove.id
      })
    }
  };

  this.resetNewQuestion = function() {
    this.newQuestion = {};
  };

  this.addNewWorkflowDriver = function() {
    $http.post("/configs/add_new_workflow_driver", this.newWorkflowDriver).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.workflowDrivers.push(xhr.data);
      this.resetNewWorkflowDriver();
    }
  };

  this.removeWorkflowDriver = function(driverToRemove) {
    $http.post("/configs/remove_workflow_driver", driverToRemove).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.workflowDrivers = _.reject(this.workflowDrivers, function(driver) {
        return driver.id == driverToRemove.id
      })
    }
  };

  this.resetNewWorkflowDriver = function() {
    this.newWorkflowDriver = {};
  };

  this.addNewSettingDriver = function() {
    $http.post("/configs/add_new_setting_driver", this.newSettingDriver).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.settingDrivers.push(xhr.data);
      this.resetNewSettingDriver();
    }
  };

  this.removeSettingDriver = function(driverToRemove) {
    $http.post("/configs/remove_setting_driver", driverToRemove).then(_.bind(onSuccess, this));

    function onSuccess(xhr) {
      this.settingDrivers = _.reject(this.settingDrivers, function(driver) {
        return driver.id == driverToRemove.id
      })
    }
  };

  this.resetNewSettingDriver = function() {
    this.newSettingDriver = {};
  };
};

m.controller("ConfigsCtrl", [
  "$http",
  "initialData",
  ConfigsCtrl
]);
