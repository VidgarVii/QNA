document.addEventListener('turbolinks:load', () => {

  if (App.questions_channel) return subscribeToQuestion();

  App.questions_channel = App.cable.subscriptions.create('QuestionsChannel', {
    connected() {
      subscribeToQuestion();
    },

    received(data) {
      var block = document.createElement('div'),
          questionList = document.getElementsByClassName('questions_list')[0];

      block.innerHTML = data;
      questionList.append(block);
    }
  });

  subscribeToQuestion = () => {
    if (document.getElementsByClassName('questions_list')[0]) {
      return App.questions_channel.perform('follow');
    } else {
      return App.questions_channel.perform('unfollow');
    }
  }
});
