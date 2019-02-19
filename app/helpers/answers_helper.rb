module AnswersHelper
  def best_button(name, answer, css)
    return if !current_user&.author_of?(answer.question) || answer.best

    button_to name, set_best_answer_path(answer),
              remote: true,
              class: css,
              method: :patch
  end
end
