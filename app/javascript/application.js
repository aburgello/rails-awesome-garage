// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function () {
    console.log("application.js is loaded");
  

    document.querySelectorAll('form').forEach(form => {
      form.addEventListener('submit', function(event) {
        event.preventDefault();
  
        fetch(this.action, {
          method: 'POST',
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
  
    const flashAlert = document.getElementById("flash-alert");
    if (flashAlert) {
      flashAlert.classList.add("slide-in");
      setTimeout(() => {
        console.log("Fade out initiated");
        flashAlert.classList.add("fade-out");
        flashAlert.addEventListener("transitionend", () => {
          flashAlert.remove();
        });
      }, 3000);
    };
});