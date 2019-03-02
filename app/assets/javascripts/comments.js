document.addEventListener('turbolinks:load', () => {
  let commentBtn = document.getElementsByClassName('add-a-comment')[0];

  let isCommentButton = (target) => target.classList.contains('add-a-comment');



  let showCommentForm = (e) => {
    if (isCommentButton(e.target)) {
      e.preventDefault();

      var id   = e.target.dataset.id,
          form = document.getElementsByClassName(`js-comment-form-${id}`)[0];

      form.classList.toggle('hidden');
    }
  };

  if (commentBtn) document.body.addEventListener('click', showCommentForm)
});
