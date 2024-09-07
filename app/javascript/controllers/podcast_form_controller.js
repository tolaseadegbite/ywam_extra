import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="podcast-form"
export default class extends Controller {
  static targets = ['selectCoverArtButton', 'coverArtFile', 'coverArtPreview']

  connect() {
    // Initialize any state or setup event listeners here
  }

  selectCoverArt(event) {
    event.preventDefault()
    this.coverArtFileTarget.click()
  }

  previewArt(fileInput, previewTarget) {
    if (!fileInput.files.length || !fileInput.files[0]) return

    const file = fileInput.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      previewTarget.src = event.target.result
    }

    reader.readAsDataURL(file)
  }

  coverArtChanged() {
    this.previewArt(this.coverArtFileTarget, this.coverArtPreviewTarget)
  }
}