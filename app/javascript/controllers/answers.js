document.addEventListener('turbolinks:load', function () {
   console.log('aaa')
});
// $(document).ready(function(){
//    console.log('aaaaa')
//    $('.edit-answer-link').on('click', function(e){
//       e.preventDefault();
//       $(this).hide();
//       let answerId = $(this).data('answerId')
//       $('form#edit-answer-' + answerId).show()
//    })
// });
// import jquery from 'jquery'
// window.$ = jquery
//
// // import "answers"
// # frozen_string_literal: true
//
// # Pin npm packages by running ./bin/importmap
//
// pin 'application', preload: true
// pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
// pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
// pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
// pin_all_from 'app/javascript/controllers', under: 'controllers'
// pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@6.1.5/lib/assets/compiled/rails-ujs.js'
// pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
// pin "react", to: "https://ga.jspm.io/npm:react@18.1.0/index.js"
// pin "react-dom", to: "https://ga.jspm.io/npm:react-dom@18.1.0/index.js"
// pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.24/nodelibs/browser/process-production.js"
// pin "scheduler", to: "https://ga.jspm.io/npm:scheduler@0.22.0/index.js"
// pin_all_from 'app/javascript/custom', under: "custom"
// pin 'answers', preload: true