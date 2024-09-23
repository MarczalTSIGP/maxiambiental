import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="avatar-preview"
export default class extends Controller {
  static targets = ["input", "image"]

  preview() {
    const file = this.inputTarget.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }
}