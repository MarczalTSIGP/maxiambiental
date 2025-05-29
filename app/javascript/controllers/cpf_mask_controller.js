// app/javascript/controllers/cpf_mask_controller.js
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    connect() {
        this.element.addEventListener('input', this.applyMask.bind(this));
    }

    applyMask() {
        const input = this.element;
        const cursorPosition = input.selectionStart;
        const rawValue = input.value.replace(/\D/g, '');
        const formattedValue = this.formatCPF(rawValue);

        if (input.value !== formattedValue) {
            input.value = formattedValue;
            input.setSelectionRange(cursorPosition, cursorPosition);
        }
    }

    formatCPF(digits) {
        return digits
            .slice(0, 11)
            .replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
    }
}
