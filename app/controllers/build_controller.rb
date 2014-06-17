require 'pdfkit'
require 'httparty'

class BuildController < ApplicationController
  def index
    questions = Question.all

    @data = {
      questions: questions.as_json
    } 
  end

  def generate_document
    create_account

    html = "<html>"
    html << add_workflow_text
    html << add_setting_text
    html << "</html>"

    kit = PDFKit.new(html, :page_size => 'Letter')
    pdf = kit.to_pdf
    send_data(pdf, :filename => "whatever.pdf", :type => "application/pdf", :disposition  => "attachment")
  end

  def create_account
    answers = Answer.answers_from(params[:answer_data])
    settings = SettingDriver.settings_for(answers)
    account_settings = {}
    site_settings = {inventory: true, external_pallet_numbers: 1, add_receipt_items_automatically: 0}
    settings.each do |setting|
      if setting.setting_type == 'account'
        account_settings.merge!(setting.setting.to_sym => setting.setting_value)
        p account_settings
      else
        site_settings.merge!(setting.setting.to_sym => setting.setting_value)
        p site_settings
      end
    end


    options = {
      basic_auth: {username: 'jasony@nulogy.com', password: 'pass'},
      body: {
        account: {name: "Account #{Time.now}"}.merge(account_settings),
        site: site_settings
      }
    }

    HTTParty.post("http://blackjohn.local:3000/accounts/special_create", options)
  end

  private

  def add_workflow_text
    answers = Answer.answers_from params[:answer_data]
    matching_workflows = WorkflowDriver.workflows_for(answers)

    html = ""
    if matching_workflows.present?
      html << "We've determined that you're using the following workflows:"
      html << matching_workflows.map {|workflow| <<-TEXT }.join("")
        <div><h2>#{workflow.code} - #{workflow.description}</h2></div>
      TEXT
    end
    html
  end

  def add_setting_text
    answers = Answer.answers_from params[:answer_data]
    matching_settings = SettingDriver.settings_for(answers)
    html = ""
    if matching_settings.present?
      html << "<br/>We've determined that you're using the following settings:"
      html << matching_settings.map {|setting| <<-TEXT }.join('')
        <div><h2>#{setting.setting_type} setting - #{setting.setting} = #{setting.setting_value}</h2></div>
      TEXT
    end
    html
  end
end
