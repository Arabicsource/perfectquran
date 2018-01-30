import { Controller } from "stimulus"

export default class extends Controller {
  toggleVisibility() {
    const toggable = this.targets.findAll("toggleVisibility");

    toggable.forEach(function(element){
      element.classList.toggle('is-hidden');
    });
  }
}
