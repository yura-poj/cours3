import consumer from "channels/consumer"

consumer.subscriptions.create("QuestionChannel", {
  connected() {
    console.log('connected!');

    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let $questions = $('#questions')
    $questions.append(data)
    // Called when there's incoming data on the websocket for this channel
  }
});
