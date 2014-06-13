require 'pdfkit'

class BuildController < ApplicationController
  def index
    TestData.build

    questions = Question.all

    @data = {
      questions: questions.as_json
    } 
  end

  def generate_document
    matching_workflows = WorkflowDriver.workflows_for(params[:answer_data])
    html = "<html>"
    html << "We've determined that you're using the following workflows:"
    html << matching_workflows.map {|workflow| <<-TEXT }.join("<br/>")
      <h1>#{workflow.code} - #{workflow.description}<h1>
    TEXT
    html << "</html>"

    kit = PDFKit.new(html, :page_size => 'Letter')
    pdf = kit.to_pdf
    send_data(pdf, :filename => "whatever.pdf", :type => "application/pdf", :disposition  => "attachment")
  end
end
