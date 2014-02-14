# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll

  belongs_to(
    :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
  )

  belongs_to(
    :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"
  )

  def respondent_has_not_already_answered_question
    new_response = existing_responses
    return if new_response.empty?

    unless new_response.length == 1 && new_response[0].id == self.id
      errors[:user_id] << "can't reply to the same question twice"
    end
  end

  def existing_responses
    Response.find_by_sql([<<-SQL, user_id, answer_choice_id])
      SELECT
        responses.*
      FROM
        responses
      INNER JOIN answer_choices
      ON
        responses.answer_choice_id = answer_choices.id
      WHERE
        responses.user_id = ?
      AND
        answer_choices.question_id = (
        SELECT
          answer_choices.question_id
        FROM
          answer_choices
        WHERE
          answer_choices.id = ?
        )
    SQL
  end

  def poll
    self.answer_choice.question.poll
  end

  def author_cant_respond_to_own_poll
    # Response
    #   .joins(:answer_choice => {:question => :poll})
    #   .where('polls.user_id = ?', self.user_id)
    #   .where('responses.answer_choice_id = ?', self.answer_choice_id)

    if self.poll.user_id == self.user_id
      errors[:user_id] << "user can't reply to their own poll"
    end
  end
end
