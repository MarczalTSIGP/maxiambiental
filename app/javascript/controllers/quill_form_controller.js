import { Controller } from "@hotwired/stimulus";
import "quill";

// Connects to data-controller="quill-form"
export default class extends Controller {
  connect() {
    this.setQuillStyles();

    const quill = new Quill("#quill_editor", {
      modules: {
        toolbar: [
          [{ header: [1, 2, 3, 4, 5, 6, false] }],
          [{ size: ["small", false, "large", "huge"] }],

          [{ font: [] }],
          [{ color: [] }, { background: [] }],
          [{ align: [] }],

          ["bold", "italic", "underline", "strike"],
          ["blockquote", "code-block"],
          ["link", "image", "video", "formula"],

          [{ list: "ordered" }, { list: "bullet" }, { list: "check" }],
          [{ indent: "-1" }, { indent: "+1" }],
          [{ direction: "rtl" }],
          [{ script: "sub" }, { script: "super" }],

          ["clean"],
        ],
      },
      theme: "snow",
    });

    try {
      quill.setContents(
        JSON.parse(document.getElementById("post_quill_content").value)
      );
    } catch (err) {
      console.log(err);
    }

    quill.on("text-change", (eventName, ...args) => {
      document.getElementById("post_quill_content").value = JSON.stringify(
        quill.getContents()
      );
    });
  }

  setQuillStyles() {
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href =
      "https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.snow.css";

    document.head.appendChild(link);
  }
}
