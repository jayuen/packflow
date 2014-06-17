require 'spec_helper'

describe SettingDriver do
  describe "#find_matching_settings" do
    let(:question) {Question.new}
    let(:setting) { SettingDriver.new(question: question, answer: 'Y') }

    it "matches when the answer matches" do
      answer = Answer.new(question, 'Y')
      matches = SettingDriver.find_matching_settings([answer], [setting])

      expect(matches.size).to eq(1)
      expect(matches.first).to be(setting)
    end

    it "does not match when the answer does not match" do
      answer = Answer.new(question, 'N')
      matches = SettingDriver.find_matching_settings([answer], [setting])

      expect(matches.size).to eq(0)
    end

    it "does not match when the question does not match" do
      another_question = Question.new
      answer = Answer.new(another_question, 'Y')
      matches = SettingDriver.find_matching_settings([answer], [setting])

      expect(matches.size).to eq(0)
    end
  end
end
