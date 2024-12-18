import { Controller } from "@hotwired/stimulus";

import "quill";
import "quill-image-uploader";

export default class QuillFormController extends Controller {
  connect() {
    this.loadQuillStyles();
    this.initializeQuillEditor();
    this.setupContentSync();
  }

  loadQuillStyles() {
    const styleLink = document.createElement("link");

    styleLink.type = "text/css";
    styleLink.rel = "stylesheet";
    styleLink.href = "https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.snow.css";

    document.head.appendChild(styleLink);
  }

  initializeQuillEditor() {
    Quill.register("modules/imageUploader", ImageUploader);

    this.contentElement = document.getElementById("post_quill_content");
    
    this.quill = new Quill("#quill_editor", {
      modules: {
        toolbar: this.getToolbarConfiguration(),
        imageUploader: {
          upload: this.handleImageUpload.bind(this)
        }
      },
      theme: "snow",
    });

    this.restoreInitialContent();
  }

  getToolbarConfiguration() {
    return [
      [{ header: [1, 2, 3, 4, 5, 6, false] }],
      [{ size: ["small", false, "large", "huge"] }],

      [{ font: [] }],
      [{ color: [] }, { background: [] }],
      [{ align: [] }],

      ["bold", "italic", "underline", "strike"],
      ["blockquote", "code-block"],
      ["link", "image", "video", "formula"],

      [{ list: "ordered" }, { list: "bullet" }],
      [{ indent: "-1" }, { indent: "+1" }],
      [{ direction: "rtl" }],
      [{ script: "sub" }, { script: "super" }],

      ["clean"],
    ];
  }

  restoreInitialContent() {
    if (!this.quill || !this.contentElement) return;

    const initialValue = this.contentElement.value.trim();

    if (!initialValue) return;

    try {
      const initialContent = JSON.parse(initialValue);

      if (initialContent && Object.keys(initialContent).length > 0) {
        this.quill.setContents(initialContent);
      }
    } catch (error) {
      console.error("Failed to restore initial content:", error);
    }
  }

  setupContentSync() {
    if (!this.quill || !this.contentElement) return;

    this.currentImages = new Set(
      Array.from(this.quill.root.querySelectorAll("img")).map((img) => img.src)
    );
  
    this.quill.on("text-change", () => {
      this.contentElement.value = JSON.stringify(this.quill.getContents());

      const newImages = new Set(
        Array.from(this.quill.root.querySelectorAll("img")).map((img) => img.src)
      );

      this.currentImages.forEach((url) => {
        if (!newImages.has(url)) {
          this.deleteImage(url);
        }
      });

      this.currentImages = newImages;
    });
  }

  handleImageUpload(file) {
    return new Promise((resolve, reject) => {
      const formData = new FormData();
      formData.append("file", file);

      fetch("/uploads", { method: "POST", body: formData })
        .then((response) => response.json())
        .then((result) => {
          if (result.url) {
            this.insertUploadedImage(result.url);
            resolve(result.url);
          } else {
            reject("Error: Response without URL");
          }
        })
        .catch((error) => {
          console.error("Upload failed:", error);
          reject(error);
        });
    });
  }

  insertUploadedImage(imageUrl) {
    if (!this.quill) return;

    const range = this.quill.getSelection();
    if (range) {
      this.quill.insertEmbed(range.index, "image", imageUrl);
    }
  }

  deleteImage(imageUrl) {
    fetch("/uploads/destroy", {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ url: imageUrl }),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Falha ao deletar a imagem");
        }
      })
      .catch((error) => {
        console.error("Erro ao deletar a imagem:", error);
      });
  }  
}