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
    WorkflowDriver.workflows_for(params[:question_data])
    html =<<-HTML
      <html>
      SOME SHIT
      </html>
    HTML

    kit = PDFKit.new(html, :page_size => 'Letter')
    pdf = kit.to_pdf
    send_data(pdf, :filename => "whatever.pdf", :type => "application/pdf", :disposition  => "attachment")
  end
end
