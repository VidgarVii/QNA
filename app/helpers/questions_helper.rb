module QuestionsHelper
  def best_button(name, question, answer_id, css)
    return unless user_signed_in? && current_user&.author_of?(question) && question.best_answer_id != answer_id

    button_to name, best_answer_question_path(question),
              params: { answer_id: answer_id },
              remote: true,
              data: {id: answer_id},
              class: css
  end
end
