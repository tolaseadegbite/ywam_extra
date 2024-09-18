import { Controller } from "@hotwired/stimulus"

const starColors = {
  'yellow' : 'text-yellow-500',
  'gray'   : 'text-gray-300'
}

// Connects to data-controller="rating"
export default class extends Controller {
  static targets = ['star', 'input'];

  setRating(e) {
    const rating = parseInt(e.target.dataset.rating);

    this.starTargets.forEach((star) => {
      if (parseInt(star.dataset.rating) <= rating) {
        star.classList.remove(starColors['gray']);
        star.classList.add(starColors['yellow']);
      } else {
        star.classList.remove(starColors['yellow']);
        star.classList.add(starColors['gray']);
      }
    });

    this.inputTarget.value = rating
  }
}