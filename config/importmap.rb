# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@6.1.5/lib/assets/compiled/rails-ujs.js'
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js'
pin 'react', to: 'https://ga.jspm.io/npm:react@18.1.0/index.js'
pin 'react-dom', to: 'https://ga.jspm.io/npm:react-dom@18.1.0/index.js'
pin 'process', to: 'https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.24/nodelibs/browser/process-production.js'
pin 'scheduler', to: 'https://ga.jspm.io/npm:scheduler@0.22.0/index.js'

pin 'activestorage', to: 'https://ga.jspm.io/npm:activestorage@5.2.8/app/assets/javascripts/activestorage.js'
pin "action_cable", to: "https://ga.jspm.io/npm:action_cable@5.0.0-beta3/index.js"
pin "react-actioncable-provider", to: "https://ga.jspm.io/npm:react-actioncable-provider@2.0.0/lib/index.js"
pin "actioncable", to: "https://ga.jspm.io/npm:actioncable@5.2.8/lib/assets/compiled/action_cable.js"
pin "create-react-class", to: "https://ga.jspm.io/npm:create-react-class@15.7.0/index.js"
pin "fbjs/lib/emptyFunction", to: "https://ga.jspm.io/npm:fbjs@0.8.18/lib/emptyFunction.js"
pin "fbjs/lib/emptyObject", to: "https://ga.jspm.io/npm:fbjs@0.8.18/lib/emptyObject.js"
pin "fbjs/lib/invariant", to: "https://ga.jspm.io/npm:fbjs@0.8.18/lib/invariant.js"
pin "object-assign", to: "https://ga.jspm.io/npm:object-assign@4.1.1/index.js"
pin "prop-types", to: "https://ga.jspm.io/npm:prop-types@15.8.1/index.js"
pin "react", to: "https://ga.jspm.io/npm:react@16.3.2/index.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
