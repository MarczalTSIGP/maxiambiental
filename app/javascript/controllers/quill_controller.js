import { Controller } from "@hotwired/stimulus";
import "quill-delta-to-html";

export default class extends Controller {
  connect() {
    const delta = JSON.parse(this.data.get("content"));

    var converter = new QuillDeltaToHtmlConverter(delta.ops, {
      inlineStyles: true,
      multiLineBlockquote: false,
    });

    this.element.innerHTML = converter.convert();
  }
}
