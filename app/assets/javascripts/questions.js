document.addEventListener('turbolinks:load', () => {

  let buttonEditQuestion = document.getElementsByClassName('edit_question_link')[0],
      answers = document.getElementsByClassName('answers_list')[0];

  let showForm = (e) => {
    e.preventDefault();
    var form = document.getElementsByClassName('edit_question_form')[0];

    form.classList.toggle('hidden');
  };

  if (buttonEditQuestion) { buttonEditQuestion.addEventListener('click', showForm) }

  // Color block for best answer

  if (answers && answers.children.length > 0) {
    first_answer = answers.children[0];

    if (first_answer.dataset.best_answer == 'true') first_answer.classList.add('best_answer');
  }
});
