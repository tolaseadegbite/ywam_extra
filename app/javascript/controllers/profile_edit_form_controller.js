import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-edit-form"
export default class extends Controller {
  static targets = ['selectCoverImageButton', 'coverImageFile', 'selectAvatarButton', 'avatarFile']

  connect() {
  }

  selectCoverImage(e) {
    e.preventDefault();
    this.coverImageFileTarget.click()
  }

  selectAvatar(e) {
    e.preventDefault();
    this.avatarFileTarget.click()
  }
}
