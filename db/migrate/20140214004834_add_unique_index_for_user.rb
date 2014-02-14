class AddUniqueIndexForUser < ActiveRecord::Migration
  def change
    add_index :users, :user_name, :unique => true
    add_index :polls, :title, :unique => true
    change_column :users, :user_name, :string, :null => false
    change_column :polls, :title, :string, :null => false
    change_column :polls, :user_id, :integer, :null => false
    change_column :questions, :poll_id, :integer, :null => false
    change_column :questions, :text, :text, :null => false
    change_column :answer_choices, :question_id, :integer, :null => false
    change_column :answer_choices, :answer, :string, :null => false
    change_column :responses, :user_id, :integer, :null => false
    change_column :responses, :answer_choice_id, :integer, :null => false
  end
end
