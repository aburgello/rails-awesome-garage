// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function () {
    const flashAlert = document.getElementById("flash-alert");
    if (flashAlert) {
        flashAlert.classList.add("slide-in"); 

        setTimeout(() => {
            flashAlert.style.opacity = "0"; 
            setTimeout(() => {
                flashAlert.remove();
            }, 500);
        }, 3000);
    }
});
