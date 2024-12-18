import { Controller } from "@hotwired/stimulus";
import "quill-delta-to-html";

export default class extends Controller {
  connect() {
    this.setQuillStyles();

    const delta = JSON.parse(this.data.get("content"));

    var converter = new QuillDeltaToHtmlConverter(delta.ops, {
      inlineStyles: true,
      multiLineBlockquote: false,
    });

    this.element.innerHTML = converter.convert();
  }

  setQuillStyles() {
    var link = document.createElement("link");

    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = "https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.snow.css";

    document.head.appendChild(link);
  }
}
