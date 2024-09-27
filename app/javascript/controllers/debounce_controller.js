import { Controller } from "@hotwired/stimulus"
import debounce from "debounce";

// Connects to data-controller="debounce"
export default class extends Controller {
  intialize() {
    this.submit = debounce(this.submit.bind(this), 300);
  }
  submit() {
    this.element.requestSubmit();
  }
}
