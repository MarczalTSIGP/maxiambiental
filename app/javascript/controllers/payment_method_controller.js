import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static targets = ['boleto', 'creditCard', 'debitCard', 'pix', 'radio'];

    connect() {
        const selected = this.radioTargets.find((radio) => radio.checked);
        if (selected) this.toggleFields({ target: selected });
    }

    toggleFields(event) {
        this.boletoTarget.classList.add('hidden');
        this.creditCardTarget.classList.add('hidden');
        this.debitCardTarget.classList.add('hidden');
        this.pixTarget.classList.add('hidden');

        switch (event.target.value) {
            case 'Boleto':
                this.boletoTarget.classList.remove('hidden');
                break;
            case 'Cartão de Crédito':
                this.creditCardTarget.classList.remove('hidden');
                break;
            case 'Cartão de Débito':
                this.debitCardTarget.classList.remove('hidden');
                break;
            case 'Pix':
                this.pixTarget.classList.remove('hidden');
                break;
        }

        targetSection.classList.add('active');
    }
}
