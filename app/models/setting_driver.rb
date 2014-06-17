class SettingDriver < ActiveRecord::Base
  belongs_to :question

  def self.settings_for answers
    settings = SettingDriver.all
    SettingDriver.find_matching_settings(answers, settings)
  end

  def self.find_matching_settings(answers, settings)
    matches = []
    settings.each do |setting|
      answer = answers.find {|a| a.question == setting.question}
      if answer.present?
        matches << setting if answer.value == setting.answer
      end
    end

    matches
  end
end
