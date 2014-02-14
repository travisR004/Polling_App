# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :uniqueness => true, :presence => true

  has_many(
    :polls,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "Poll",
    :dependent => :destroy
  )

  has_many(
    :responses,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "Response"
  )

  def completed_polls(completed = true)
    poll_answers = all_responses

    poll_questions(poll_answers).select do |poll|
      (poll.questions.length == poll_answers[poll.id]) == completed
    end
  end

  def uncompleted_polls
    completed_polls(false)
  end

  def poll_questions(poll_answers)
    poll_questions = Poll.where(id: poll_answers.keys).includes(:questions)
  end

  def all_responses
    all_responses = self.responses.includes(:answer_choice => [:question => [:poll]])
    poll_answers = Hash.new(0)
    all_responses.each do |response|
      current_poll = response.answer_choice.question.poll
      poll_answers[current_poll.id] += 1
    end
    poll_answers
  end
end
