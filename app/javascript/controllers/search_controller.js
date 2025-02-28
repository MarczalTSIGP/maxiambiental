import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
    static targets = ["input"];
    static values = { baseUrl: String, cleanUrl: String };

    search(event) {
        event.preventDefault();
        const term = this.inputTarget.value.trim();

        if (term) {
            const encodedTerm = encodeURIComponent(term);
            window.location.href = `${this.baseUrlValue}/${encodedTerm}`;
        } else {
            window.location.href = this.cleanUrlValue;
        }
    }

    clearCheck() {
        if (!this.inputTarget.value.trim()) {
            window.location.href = this.cleanUrlValue;
        }
    }
}
