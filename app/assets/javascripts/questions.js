document.addEventListener('turbolinks:load', () => {

  let buttonEditQuestion = document.getElementsByClassName('edit_question_link')[0];

  let showForm = (e) => {
    e.preventDefault();
    var form = document.getElementsByClassName('edit_question_form')[0];

    form.classList.toggle('hidden');
  };

  if (buttonEditQuestion) { buttonEditQuestion.addEventListener('click', showForm) }
});
