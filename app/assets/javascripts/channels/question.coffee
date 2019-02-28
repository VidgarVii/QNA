$ ->
  questionsList = document.getElementsByClassName('questions_list')[0]

  App.room = App.cable.subscriptions.create 'QuestionsChannel',
    connected: ->
      @perform 'show'

    received: (data) ->
      block = document.createElement('div')
      block.innerHTML = data
      questionsList.append(block)
