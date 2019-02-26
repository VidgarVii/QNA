document.addEventListener('turbolinks:load', () => {

  // For question

  let vote = document.getElementsByClassName('vote')[0];

  let setQuestionRating = (e) => {
    var rating = vote.getElementsByClassName('rating')[0];

    rating.innerHTML = e.detail[0].score;
  };

  let errorRating = (e) => {
    var error = document.getElementsByClassName('alert-danger')[0];

    error.innerText = e.detail[0]
  };

  if (vote) vote.addEventListener('ajax:success', setQuestionRating);
  if (vote) vote.addEventListener('ajax:error', errorRating);

  // For answers

  let answers = document.getElementsByClassName('answers_list')[0];

  let setAnswerRating = (e) => {
    var answer_id    = e.detail[0].rateable_id,
        rating_block = document.getElementById(`vote-answer-${answer_id}`),
        rating = rating_block.getElementsByClassName('rating')[0];

    rating.innerHTML = e.detail[0].score;
  };

  if (answers) answers.addEventListener('ajax:success', setAnswerRating);
  if (answers) answers.addEventListener('ajax:error', errorRating);
});
