import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["sidebar"];

  toggle() {
    console.log("test");
    this.sidebarTarget.classList.toggle("translate-x-0");
    this.sidebarTarget.classList.toggle("-translate-x-full");
  }
}
