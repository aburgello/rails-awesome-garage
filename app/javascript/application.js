// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@rails/ujs";

document.addEventListener("turbo:load", function () {
    console.log("application.js is loaded");
    handleDeleteReview(); // Attach delete review handlers
  });
document.addEventListener('turbo:load',function() {

    const filterToggle = document.getElementById('filter-toggle');
    const filterSection = document.getElementById('filter-section');
  
    console.log("filterSection is defined");

    if (filterToggle) {
        console.log("filterToggle is defined");

      filterToggle.addEventListener('click', () => {
        filterSection.classList.toggle('hidden');
      });
    }
});



document.addEventListener('turbo:load', function() {
    document.querySelectorAll('.show-car').forEach(function(element) {
        element.addEventListener('click', function(event) {
        if (element.classList.contains('show-car')) {
            element.classList.remove('show-car');
            element.classList.remove('h-64');
            element.classList.add('h-auto');
            
        } else {
            element.classList.remove('h-auto');
            element.classList.add('show-car');
            element.classList.add('h-64');

        }
        });
    });
    }); 

document.addEventListener("turbo:load", function() {
    const stars = document.querySelectorAll('input[name="review[rating]"]');

    stars.forEach((star) => {
        star.addEventListener("mouseenter", () => {
            const rating = star.value;
            stars.forEach((s) => {
                const starIcon = s.nextElementSibling;
                if (starIcon && s.value <= rating) {
                    starIcon.classList.add("text-yellow-500");
                }
            });
        });

        star.addEventListener("mouseleave", () => {
            stars.forEach((s) => {
                const starIcon = s.nextElementSibling;
                if (starIcon && !s.checked) {
                    starIcon.classList.remove("text-yellow-500");
                }
            });
        });

        star.addEventListener("change", () => {
            stars.forEach((s) => {
                const starIcon = s.nextElementSibling;
                if (starIcon) {
                    starIcon.classList.remove("text-yellow-500");
                }
            });
            for (let i = 0; i < star.value; i++) {
                const starIcon = stars[i].nextElementSibling;
                if (starIcon) {
                    starIcon.classList.add("text-yellow-500");
                }
            }
        });
    });
});
document.addEventListener('turbo:load', function() {

document.addEventListener("DOMContentLoaded", function () {
    const voteButtons = document.querySelectorAll('.vote-btn');
  
    voteButtons.forEach(button => {
      button.addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default form submission
  
        const carId = this.dataset.carId; // Get the car ID from the data attribute
        fetch(`/battles/vote/${carId}`, {
            method: "POST",
            headers: {
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
              "Content-Type": "application/json"
            },
            body: JSON.stringify({ car_id: carId })
          })
          .then(response => {
            if (response.ok) {
              return response.text(); // Change this line to handle text response
            }
            throw new Error('Network response was not ok.');
          })
          .then(data => {
            // Assuming data contains the rendered JavaScript from vote.js.erb
            eval(data); // Executes the JS from vote.js.erb
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
          });
          
          
      });
    });
  });
});
  

  function handleFormSubmission() {
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
  
  function handleDeleteReview() {
    document.querySelectorAll('.delete-review').forEach(button => {
      button.addEventListener('click', function(event) {
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
            Swal.fire('Cancelled', 'Your review is safe :)', 'error');
          }
        });
      });
    });
  }
  


