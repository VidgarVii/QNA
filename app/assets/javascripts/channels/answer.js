document.addEventListener('turbolinks:load', () => {

  if (App.answers_channel) return subscribeToAnswer();

  App.answers_channel = App.cable.subscriptions.create('AnswersChannel', {
    connected() {
      subscribeToAnswer();
    },

    received(data) {
      var block = document.createElement('div'),
          answersList = document.getElementsByClassName('answers_list')[0];

      block.innerHTML = data;
      answersList.append(block);
    }
  });

  subscribeToAnswer = () => {
    if (document.getElementsByClassName('answers_list')[0]) {
      return App.answers_channel.perform('follow', {data: gon.question_id});
    } else {
      return App.answers_channel.perform('unfollow');
    }
  }
});
