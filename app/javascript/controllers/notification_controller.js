import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    super.connect()
    console.log('Do what you want here.')
  }
}
