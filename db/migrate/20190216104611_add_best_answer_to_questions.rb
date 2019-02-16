class AddBestAnswerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :best_answer, :integer
  end
end
