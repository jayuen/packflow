class Answer
  attr_accessor :question, :value

  def initialize question, value
    @question = question
    @value = value
  end

  def self.answers_from answer_data
    answer_data.map do |question_code, answer|
      question = Question.find_by_code(question_code)
      Answer.new(question, answer)
    end
  end
end
