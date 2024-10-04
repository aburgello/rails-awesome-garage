// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@rails/ujs";

document.addEventListener("turbo:load", function () {
    console.log("application.js is loaded");
    handleDeleteReview(); // Attach delete review handlers
  });
  document.querySelectorAll('.h-64').forEach(function(element) {
    element.addEventListener('click', function(event) {
        element.classList.toggle('h-64');
        element.classList.toggle('h-auto');
    });
});

  // This function handles form submissions using fetch API
  function handleFormSubmission() {
    document.querySelectorAll('form').forEach(form => {
      console.log("Attaching submit listener to form: ", form);
  
      form.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent default form submission
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
          eval(data); // Evaluate the returned JS
        })
        .catch(error => console.error('There was a problem with your fetch operation:', error));
      });
    });
  }
  
  // This function handles the delete button functionality
  function handleDeleteReview() {
    document.querySelectorAll('.delete-review').forEach(button => {
      button.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default action of the button
  
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
            fetch(reviewUrl, {
              method: 'DELETE',
              headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                'Accept': 'application/javascript'
              }
            })
            .then(response => {
              if (response.ok) {
                const reviewElement = document.getElementById(`review_${reviewId}`);
                if (reviewElement) {
                  reviewElement.remove(); // Remove the review from the DOM
                }
                // Success alert for deletion
                Swal.fire({
                  title: 'Deleted!',
                  text: 'Your review has been deleted.',
                  icon: 'success',
                  confirmButtonText: 'OK'
                });
              } else {
                throw new Error('Network response was not ok');
              }
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
  
