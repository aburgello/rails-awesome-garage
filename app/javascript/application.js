// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// Function to handle form submissions via AJAX
function handleFormSubmission() {
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
}

// Function to handle delete review button clicks
function handleDeleteReview() {
  document.querySelectorAll('.delete-review').forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault(); // Prevent the default button behavior

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
          // Proceed with deletion
          fetch(reviewUrl, {
            method: 'DELETE',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
              'Accept': 'application/javascript'
            }
          })
          .then(response => {
            if (response.ok) {
              // Remove the review from the DOM
              const reviewElement = document.getElementById(`review_${reviewId}`);
              if (reviewElement) {
                reviewElement.remove();
              }
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
          // Show cancellation message
          Swal.fire('Cancelled', 'Your review is safe :)', 'error');
        }
      });
    });
  });
}

// Listen for Turbo page loads to reapply event listeners
document.addEventListener("turbo:load", function () {
  console.log("application.js is loaded");
  handleFormSubmission(); // Set up form submission handling
  handleDeleteReview();   // Set up delete review handling
});

const flashAlert = document.getElementById("flash-alert");
if (flashAlert) {
  // Show alert
  flashAlert.classList.add("slide-in");
  flashAlert.classList.remove("slide-in");
  flashAlert.classList.add("fade-out");
  flashAlert.addEventListener("transitionend", () => {
      flashAlert.remove(); // Remove alert from DOM after fade-out completes
    })};
