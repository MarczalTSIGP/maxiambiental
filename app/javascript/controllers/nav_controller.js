import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nav"
export default class extends Controller {
  static targets = ["logo", "menu", "links"]

  connect() {
    window.addEventListener('scroll', this.toggleBackground.bind(this))
  }

  disconnect() {
    window.removeEventListener('scroll', this.toggleBackground.bind(this))
  }

  toggleBackground() {
    if (window.scrollY > 50) {
      this.setNavClasses(['bg-white', 'shadow-md'], ['bg-transparent'])
      this.setLinksColor('text-green-700', 'text-white')
      this.logoTarget.classList.remove('hidden')
    } else {
      this.setNavClasses(['bg-transparent'], ['bg-white', 'shadow-md'])
      this.setLinksColor('text-white', 'text-green-700')
      this.logoTarget.classList.add('hidden')
    }
  }

  setNavClasses(addClasses, removeClasses) {
    addClasses.forEach(className => this.element.classList.add(className))
    removeClasses.forEach(className => this.element.classList.remove(className))
  }

  setLinksColor(addClass, removeClass) {
    this.linksTargets.forEach(link => {
      link.classList.add(addClass)
      link.classList.remove(removeClass)
    })
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden')
  }
}
