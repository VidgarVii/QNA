document.addEventListener('turbolinks:load', () => {

  var question = document.getElementsByClassName('question')[0];


  if (question) {
    var questionId = question.dataset.id;

    App.comments_channel = App.cable.subscriptions.create(
      {'channel': 'CommentsChannel', 'id': questionId}, {
        connected() {
          subscribeToComment();
        },

        received(data) {
          if (gon.user_id != data.user_id) {

            var block = document.createElement('div'),
              answersList = document.getElementsByClassName('answers_list')[0];

            block.innerHTML = data.body;
            answersList.append(block);
          }
        }
      });

    subscribeToComment = () => {
      if (document.getElementsByClassName('answers_list')[0]) {
        return App.comments_channel.perform('follow');
      } else {
        return App.comments_channel.perform('unfollow');
      }
    }
  }
});
