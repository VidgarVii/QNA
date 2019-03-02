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
            pushComment(data.commentable_id, data.body)
          }
        }
      });
  }

  let pushComment = (id, data) => {
    var commentsList = document.getElementById(`comments_list-${id}`),
        block = document.createElement('div');
        block.innerHTML = JST["templates/comment"]({body: data});

      commentsList.append(block);
  };


  let subscribeToComment = () => {
    if (document.getElementsByClassName('answers_list')[0]) {
      return App.comments_channel.perform('follow');
    } else {
      return App.comments_channel.perform('unfollow');
    }
  }

});
