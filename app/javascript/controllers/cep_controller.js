import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static targets = ['cep', 'address', 'city', 'state'];

    connect() {
        this.cepTarget.addEventListener('input', this.formatCep.bind(this));
        this.cepTarget.addEventListener('blur', this.fetchAddress.bind(this));

        this.cepTarget.maxLength = 9; // 00000-000
    }

    formatCep(event) {
        let value = event.target.value.replace(/\D/g, '');

        if (value.length > 5) {
            value = `${value.substring(0, 5)}-${value.substring(5, 8)}`;
        }

        event.target.value = value;
    }

    fetchAddress() {
        const rawCep = this.cepTarget.value.replace(/\D/g, '');

        if (rawCep.length !== 8) {
            this.clearAddressFields();
            return;
        }

        this.showLoading(true);

        fetch(`https://viacep.com.br/ws/${rawCep}/json/`)
            .then((response) => {
                if (!response.ok) throw new Error('Erro na requisição');
                return response.json();
            })
            .then((data) => {
                if (data.erro) {
                    throw new Error('CEP não encontrado');
                }
                this.fillAddressFields(data);
            })
            .catch((error) => {
                console.error('Erro:', error.message);
                this.clearAddressFields();
                this.showError(error.message);
            })
            .finally(() => this.showLoading(false));
    }

    fillAddressFields(data) {
        this.addressTarget.value = data.logradouro || '';
        this.cityTarget.value = data.localidade || '';
        this.stateTarget.value = data.uf || '';
    }

    clearAddressFields() {
        this.addressTarget.value = '';
        this.cityTarget.value = '';
        this.stateTarget.value = '';
    }

    showLoading(show) {
        if (show) {
            this.cepTarget.classList.add('loading');
        } else {
            this.cepTarget.classList.remove('loading');
        }
    }

    showError(message) {
        console.error(message);
    }
}
