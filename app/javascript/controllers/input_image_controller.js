import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="input-image"
export default class extends Controller {
    static targets = ["preview", "fileName"];

    loadFile(event) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const file = input.files[0];
            // Atualiza o elemento que mostra o nome do arquivo
            this.fileNameTarget.textContent = file.name;

            const reader = new FileReader();
            reader.onload = (e) => {
                this.previewTarget.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
}
