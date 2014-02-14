# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  validates :title, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

  belongs_to(
    :user,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "User"
  )

  has_many(
    :questions,
    :primary_key => :id,
    :foreign_key => :poll_id,
    :class_name => "Question",
    :dependent => :destroy
  )

  def results
    questions = self.questions.includes(:answer_choices => [:responses])
    Hash[questions.pluck(:text).uniq.zip(questions.map(&:results))]
  end
end
