class QuillEditorManager {
    constructor(editorSelector, hiddenFieldSelector) {
        this.quill = null;
        this.editorSelector = editorSelector;
        this.hiddenFieldSelector = hiddenFieldSelector;
        this.initialize();
    }

    initialize() {
        this.setupQuillEditor();
        this.bindHiddenFieldSync();
        this.populateExistingContent();
    }

    setupQuillEditor() {
        this.quill = new Quill(this.editorSelector, {
            theme: "snow",
            placeholder: "Digite aqui o conteúdo...",
            modules: {
                toolbar: {
                    container: this.getToolbarConfiguration(),
                    handlers: {
                        "resize-small": () => this.resizeImage("small"),
                        "resize-medium": () => this.resizeImage("medium"),
                        "resize-large": () => this.resizeImage("large"),
                    }
                }
            }
        });
    }

    getToolbarConfiguration() {
        return [
            ["bold", "italic", "underline", "strike"],
            [{ header: [1, 2, 3, false] }],
            [{ font: [] }],
            [{ size: ["small", false, "large", "huge"] }],

            [
                { color: [] },
                { background: [] }
            ],
            [{ align: [] }],

            [{ list: "ordered" }, { list: "bullet" }],
            [{ indent: "-1" }, { indent: "+1" }],

            ["link", "image", "video"],

            ["clean"],
            ["resize-small", "resize-medium", "resize-large"],
        ];
    }

    bindHiddenFieldSync() {
        const hiddenField = document.querySelector(this.hiddenFieldSelector);

        this.quill.on("text-change", () => {
            hiddenField.value = this.quill.root.innerHTML;
        });
    }

    resizeImage(size) {
        const range = this.quill.getSelection();

        if (!range) return;

        const [leaf] = this.quill.getLeaf(range.index);

        if (!leaf || leaf.domNode.tagName !== "IMG") return;

        const sizeMap = {
            "small": "25%",
            "medium": "50%",
            "large": "100%"
        };

        leaf.domNode.style.width = sizeMap[size] || "100%";
    }

    populateExistingContent() {
        const hiddenField = document.querySelector(this.hiddenFieldSelector);

        if (hiddenField.value) {
            this.quill.root.innerHTML = hiddenField.value;
        }
    }
}

document.addEventListener("turbo:load", () => {
    const quillElement = document.querySelector("#editor");

    if (quillElement) {
        new QuillEditorManager("#editor", "#hidden-content");
    }
});
