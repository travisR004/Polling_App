# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, :presence => true

  belongs_to(
    :poll,
    :primary_key => :id,
    :foreign_key => :poll_id,
    :class_name => "Poll"
  )

  has_many(
    :answer_choices,
    :primary_key => :id,
    :foreign_key => :question_id,
    :class_name => "AnswerChoice",
    :dependent => :destroy
  )

  def results
    answer_choices = self.answer_choices.includes(:responses)
    {}.tap do |question_results|
      answer_choices.each do |answer_choice|
        question_results[answer_choice.answer] = answer_choice.responses.length
      end
    end
  end
end
