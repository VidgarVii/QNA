document.addEventListener('turbolinks:load', () => {

  var question = document.getElementsByClassName('question')[0];
  var answersList = document.getElementsByClassName('answers_list')[0];

  if (question && answersList) {
    var questionId = question.dataset.id;

    // if (App.answers_channel) return subscribeToAnswer();

    App.answers_channel = App.cable.subscriptions.create(
      {'channel': 'AnswersChannel', 'question_id': questionId}, {
        connected() {
          subscribeToAnswer();
        },

        received(data) {
          if (gon.user_id != data.user_id) {
            console.log(data);
          }

          // var block = document.createElement('div'),
          //     answersList = document.getElementsByClassName('answers_list')[0];
          //
          // block.innerHTML = data;
          // answersList.append(block);
        }
      });

    subscribeToAnswer = () => {

      var question = document.getElementsByClassName('question')[0],
        questionId = question.dataset.id;

      if (document.getElementsByClassName('answers_list')[0]) {
        return App.answers_channel.perform('follow');
      } else {
        return App.answers_channel.perform('unfollow');
      }
    }
  }
});
