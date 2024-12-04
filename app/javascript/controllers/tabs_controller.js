import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tabs"
export default class extends Controller {
    static targets = ["link"];
  
    connect() {
        this.setActiveLink();
    }
    
    setActiveLink() {
        this.linkTargets.forEach(link => {
            const isActive = link.href === window.location.href

            link.classList.toggle("text-green-600", isActive)
            link.classList.toggle("border-green-600", isActive)
            link.classList.toggle("hover:text-green-600", isActive)
            link.classList.toggle("hover:border-green-300", isActive)
        })
    }
  }