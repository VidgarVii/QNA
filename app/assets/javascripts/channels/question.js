document.addEventListener('turbolinks:load', () => {

  if (!App.questions_channel) {
    App.questions_channel = App.cable.subscriptions.create('QuestionsChannel', {
      connected() {
        this.perform('follow');
      },

      received(data) {
        console.log('RECEIVED');
        console.log(questionList);
        var block = document.createElement('div'),
            questionList = document.getElementsByClassName('questions_list')[0];

        block.innerHTML = data;
        questionList.append(block);
      }
    });
  }

  if(App.questions_channel && document.getElementsByClassName('questions_list')[0]){
    App.questions_channel.perform('follow');
  } else {
    App.questions_channel.perform('unfollow');
  }
});
