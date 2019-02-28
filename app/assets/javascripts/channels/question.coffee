document.addEventListener 'turbolinks:load', ->

  questionsList = document.getElementsByClassName('questions_list')[0]
  answersList = document.getElementsByClassName('answers_list')[0]

  if gon.template == 'questions#index'
    App.question_channel = App.cable.subscriptions.create 'QuestionsChannel',
      connected: ->
        @perform 'follow'

      received: (data) ->
        block = document.createElement('div')
        block.innerHTML = data
        questionsList.append(block)


