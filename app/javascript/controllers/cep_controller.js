// app/javascript/controllers/cep_controller.js
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static targets = ['cep', 'address', 'city', 'state'];

    connect() {
        this.cepTarget.addEventListener('blur', this.fetchAddress.bind(this));
    }

    fetchAddress() {
        const cep = this.cepTarget.value.replace(/\D/g, '');

        if (cep.length !== 8) return;

        fetch(`https://viacep.com.br/ws/${cep}/json/`)
            .then((response) => response.json())
            .then((data) => {
                if (!data.erro) {
                    this.addressTarget.value = data.logradouro;
                    this.cityTarget.value = data.localidade;
                    this.stateTarget.value = data.uf;
                } else {
                    console.error('CEP não encontrado');
                }
            })
            .catch((error) => console.error('Erro ao buscar CEP:', error));
    }
}
