require 'pdfkit'

class BuildController < ApplicationController
  def index
    questions = Question.all

    @data = {
      questions: questions.as_json
    } 
  end

  def generate_document
    html = "<html>"
    html << add_workflow_text
    html << add_setting_text
    html << "</html>"

    kit = PDFKit.new(html, :page_size => 'Letter')
    pdf = kit.to_pdf
    send_data(pdf, :filename => "whatever.pdf", :type => "application/pdf", :disposition  => "attachment")
  end

  def create_account
  end

  private

  def add_workflow_text
    answers = Answer.answers_from params[:answer_data]
    matching_workflows = WorkflowDriver.workflows_for(answers)
    html = "We've determined that you're using the following workflows:"
    html << matching_workflows.map {|workflow| <<-TEXT }.join("")
      <div><h3>#{workflow.code} - #{workflow.description}</h2></div>
    TEXT
    html
  end

  def add_setting_text
    answers = Answer.answers_from params[:answer_data]
    matching_settings = SettingDriver.settings_for(answers)
    html = "We've determined that you're using the following settings:"
    html << matching_settings.map {|setting| <<-TEXT }.join('')
      <div><h2>#{setting.setting_type} setting - #{setting.setting} = #{setting.setting_value}</h2></div>
    TEXT
  end
end
