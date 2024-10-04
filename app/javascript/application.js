// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@rails/ujs";

document.addEventListener("DOMContentLoaded", function () {
    handleDeleteReview();
  });

function handleFormSubmission() {
    if (formListenerAttached) return;
    document.querySelectorAll('form').forEach(form => {
        console.log("Attaching submit listener to form: ", form);

        form.addEventListener('submit', function(event) {
            event.preventDefault();
            fetch(this.action, {
                method: this.method,
                headers: {
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
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

   
  function handleFormSubmit(event) {
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
  }
  function handleDeleteReview() {
    console.log("handleDeleteReview function called");
    document.querySelectorAll('.delete-review').forEach(button => {
      button.addEventListener('click', function(event) {
        console.log("Delete button clicked"); // Check if this logs
        event.preventDefault();
  
        const reviewId = this.getAttribute('data-review-id');
        const reviewUrl = this.getAttribute('data-review-url');
  
        Swal.fire({
          title: 'Are you sure?',
          text: 'Once deleted, you will not be able to recover this review!',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Yes, delete it!',
          cancelButtonText: 'No, keep it'
        }).then((result) => {
          if (result.isConfirmed) {
            console.log("Confirmed delete"); // Check if this logs
            fetch(reviewUrl, {
              method: 'DELETE',
              headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                'Accept': 'application/javascript'
              }
            })
            .then(response => {
              if (response.ok) {
                Swal.fire({
                  title: 'Deleted!',
                  text: 'Your review has been deleted.',
                  icon: 'success',
                  confirmButtonText: 'OK'
                });
                return response.text(); // This will include the response from destroy.js.erb
              } else {
                throw new Error('Network response was not ok');
              }
            })
            .then(data => {
              eval(data); // This will execute the code in destroy.js.erb
            })
            .catch(error => {
              console.error('There was a problem with your fetch operation:', error);
            });
          } else {
            Swal.fire('Cancelled', 'Your review is safe :)', 'error');
          }
        });
      });
    });
  }
  
  

document.addEventListener("turbo:load", function () {
  console.log("application.js is loaded");
  handleFormSubmission();
});



