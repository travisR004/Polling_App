# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(user_name: "Anne")
u2 = User.create!(user_name: "Bill")
# u3 = User.create!(user_name: "Carol")

p1 = Poll.create!(title: "Best Dog", :user_id => 1)
p2 = Poll.create!(title: "Best Elephant",:user_id =>  2)
# p3 = Poll.create!(title: "Best Ferret", :user_id => 3)
# p4 = Poll.create!(title: "Greatest Goat", :user_id => 3)


q1 = Question.create!(:text => "What is your favorite dog?", :poll_id => 1)
q2 = Question.create!(:text => "What is your favorite elephant?", :poll_id => 2)
# q3 = Question.create!(:text => "What is your favorite ferret?", :poll_id => 3)
# q4 = Question.create!(:text => "What is your favorite goat?", :poll_id => 4)

a1 = AnswerChoice.create!(:answer => "Beethoven", :question_id => 1)
a2 = AnswerChoice.create!(:answer => "Old Yeller", :question_id => 1)
a3 = AnswerChoice.create!(:answer => "Dumbo", :question_id => 2)
a4 = AnswerChoice.create!(:answer => "Robert", :question_id => 2)
# a5 = AnswerChoice.create!(:answer => "Frank", :question_id => 3)
# a6 = AnswerChoice.create!(:answer => "George", :question_id => 3)
# a7 = AnswerChoice.create!(:answer => "Robert", :question_id => 3)

r1 = Response.create!(:user_id => 1, :answer_choice_id => 1)
r2 = Response.create!(:user_id => 2, :answer_choice_id => 1)
r3 = Response.create!(:user_id => 1, :answer_choice_id => 3)
# r4 = Response.create!(:user_id => 2, :answer_choice_id => 5)