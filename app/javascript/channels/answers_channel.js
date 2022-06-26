import consumer from "channels/consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected() {
    console.log('connected!')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    let $question = $('#question-' + data.question.toString())
    let $answers = $question.children('.answers')
    $answers.append(data.body)
    // Called when there's incoming data on the websocket for this channel
  }
});
