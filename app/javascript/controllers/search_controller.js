import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search"
export default class extends Controller {
    static targets = ['input'];
    static values = { baseUrl: String };

    search(event) {
        event.preventDefault();
        const term = this.inputTarget.value.trim();

        if (term) {
            const encodedTerm = encodeURIComponent(term);
            window.location.href = `${this.baseUrlValue}/search/${encodedTerm}`;
        } else {
            window.location.href = this.baseUrlValue;
        }
    }

    clearCheck() {
        if (!this.inputTarget.value.trim()) {
            window.location.href = this.baseUrlValue;
        }
    }
}
