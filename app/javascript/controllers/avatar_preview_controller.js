import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="avatar-preview"
export default class extends Controller {
  static targets = ["input", "image", "edit", "check", "trash", "label"]

  connect() {
    this.checkTarget.classList.add("hidden");
    this.trashTarget.classList.add("hidden");
    this.labelTarget.classList.add("hidden");

    this.isEditMode = false;

    document.addEventListener("click", this.outsideClick.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClick.bind(this));
  }

  preview() {
    const file = this.inputTarget.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
        this.checkTarget.classList.remove("hidden");
        this.trashTarget.classList.remove("hidden");
        this.editTarget.classList.add("hidden");
      };
      reader.readAsDataURL(file);
    }
  }

  toggleEdit() {
    this.checkTarget.classList.remove("hidden");
    this.trashTarget.classList.remove("hidden");
    this.labelTarget.classList.remove("hidden");
    this.editTarget.classList.add("hidden");

    this.isEditMode = true;
  }

  selectImage() {
    if (this.isEditMode) {
      this.inputTarget.click();
    }
  }

  outsideClick(event) {
    if (!this.element.contains(event.target) && this.isEditMode) {
      this.cancelEdit();
    }
  }

  cancelEdit() {
    this.checkTarget.classList.add("hidden");
    this.trashTarget.classList.add("hidden");
    this.labelTarget.classList.add("hidden");
    this.editTarget.classList.remove("hidden");

    this.isEditMode = false;
  }
}