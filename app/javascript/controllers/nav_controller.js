import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nav"
export default class extends Controller {
  static targets = ["logo", "menu"]

  connect() {
    window.addEventListener('scroll', this.toggleBackground.bind(this))
  }

  disconnect() {
    window.removeEventListener('scroll', this.toggleBackground.bind(this))
  }

  toggleBackground() {
    if (window.scrollY > 50) {
      this.element.classList.add('bg-white', 'shadow-md')
      this.element.classList.remove('bg-transparent')

      this.logoTarget.classList.remove('hidden')
    } else {
      this.element.classList.add('bg-transparent')
      this.element.classList.remove('bg-white', 'shadow-md')

      this.logoTarget.classList.add('hidden')
    }
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden')
  }
}
