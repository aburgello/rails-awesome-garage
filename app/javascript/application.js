// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";


function handleFormSubmission() {
    // Only target forms with the class 'favourites-form'
    document.querySelectorAll('form.favourites-form').forEach(form => {
      form.addEventListener('submit', function(event) {
        event.preventDefault();
  
        fetch(this.action, {
          method: form.getAttribute('method') || 'POST',
          headers: {
            'Accept': 'application/javascript',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: new URLSearchParams(new FormData(this))
        })
        .then(response => {
          if (!response.ok) throw new Error('Network response was not ok');
          return response.text();
        })
        .then(data => {
          eval(data);
        })
        .catch(error => console.error('There was a problem with your fetch operation:', error));
      });
    });
  }
  



document.addEventListener("turbo:load", function () {
  console.log("application.js is loaded");
  handleFormSubmission();
});

const flashAlert = document.getElementById("flash-alert");
if (flashAlert) {
  flashAlert.classList.add("slide-in");
  flashAlert.classList.remove("slide-in");
  flashAlert.classList.add("fade-out");
  flashAlert.addEventListener("transitionend", () => {
      flashAlert.remove();
    })};
