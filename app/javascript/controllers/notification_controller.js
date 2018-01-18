import { Controller } from "stimulus"

export default class extends Controller {
  close(event) {
    event.preventDefault();
    const element = this.targets.find('closable');
    element.classList.add('is-invisible');
  }
}