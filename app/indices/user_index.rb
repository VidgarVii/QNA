ThinkingSphinx::Index.define :user, with: :active_record do
  #fileds
  indexes email, sortable: true
  indexes questions.title, as: :question_title, sortable: true
  indexes answers.body, as: :answer_body
  indexes comments.body, as: :comment_body
end
