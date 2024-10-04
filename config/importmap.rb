# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/ujs", to: "rails-ujs.js"
pin "sweetalert2", to: "sweetalert2.js"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"
