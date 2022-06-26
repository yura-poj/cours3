// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import Rails from "@rails/ujs"
Rails.start()
import "@hotwired/turbo-rails"
import "controllers"
import jquery from 'jquery'
window.$ = jquery

// import ActionCable from 'action_cable'
// let App = {};
// App.cable = ActionCable.createConsumer();

import * as ActiveStorage from "activestorage"
ActiveStorage.start()
import "channels"
