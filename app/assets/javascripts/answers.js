document.addEventListener('turbolinks:load', () => {

  let answers = document.getElementsByClassName('answers_list')[0];

  let isEditButton = (target) => target.classList.contains('edit-answer-link');

  let showForm = (e) => {
    if (isEditButton(e.target)) {
      e.preventDefault();

      var answerId = e.target.dataset.answerId,
          form = answers.getElementsByClassName(`js_form-${answerId}`)[0];

      form.classList.toggle('hidden');
    }
  };

  if (answers) { answers.addEventListener('click', showForm) }
});
