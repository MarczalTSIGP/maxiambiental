import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["sidebar"];

  connect() {
    document.addEventListener("click", this.closeOnOutsideClick.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick.bind(this));
  }

  toggle() {
    this.sidebarTarget.classList.toggle("-translate-x-full");
  }

  closeOnOutsideClick(event) {
    if (!this.sidebarTarget.contains(event.target) && !event.target.closest("[data-action='click->sidebar#toggle']")) {
      this.sidebarTarget.classList.add("-translate-x-full");
    }
  }
}
