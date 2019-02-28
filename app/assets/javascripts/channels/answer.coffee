document.addEventListener 'turbolinks:load', ->

  App.answer_channel = App.cable.subscriptions.create 'AnswersChannel',
    connected: ->
      @perform 'follow', gon.question_id

    received: (data) ->
      console.log data
