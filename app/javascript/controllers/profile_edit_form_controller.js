import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-edit-form"
export default class extends Controller {
  static targets = ['selectCoverImageButton', 'coverImageFile', 'coverImagePreview', 'selectAvatarButton', 'avatarFile', 'avatarPreview']

  connect() {
    // Initialize any state or setup event listeners here
  }

  selectCoverImage(event) {
    event.preventDefault()
    this.coverImageFileTarget.click()
  }

  selectAvatar(event) {
    event.preventDefault()
    this.avatarFileTarget.click()
  }

  previewImage(fileInput, previewTarget) {
    if (!fileInput.files.length || !fileInput.files[0]) return

    const file = fileInput.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      previewTarget.src = event.target.result
    }

    reader.readAsDataURL(file)
  }

  coverImageChanged() {
    this.previewImage(this.coverImageFileTarget, this.coverImagePreviewTarget)
  }

  avatarChanged() {
    this.previewImage(this.avatarFileTarget, this.avatarPreviewTarget)
  }
}