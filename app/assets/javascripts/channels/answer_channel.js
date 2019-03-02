document.addEventListener('turbolinks:load', () => {

  var question = document.getElementsByClassName('question')[0],
      answersList = document.getElementsByClassName('answers_list')[0];

  if (question && answersList) {
    var questionId = question.dataset.id;

    App.answers_channel = App.cable.subscriptions.create(
      {'channel': 'AnswersChannel', 'question_id': questionId}, {
        connected() {
          subscribeToAnswer();
        },

        received(data) {
          if (gon.user_id != data.answer.user_id) {

            var block = document.createElement('div'),
                answersList = document.getElementsByClassName('answers_list')[0];

            block.innerHTML = JST["templates/answer"]({
              answer: data.answer,
              answer_links: data.links,
              author: data.author,
              answer_files: data.files});

            answersList.append(block);
          }
        }
      });

    subscribeToAnswer = () => {
      if (document.getElementsByClassName('answers_list')[0]) {
        return App.answers_channel.perform('follow');
      } else {
        return App.answers_channel.perform('unfollow');
      }
    }
  }
});
