import { Controller } from "stimulus"

export default class extends Controller {
  toggle(event){
    event.preventDefault();

    const toggable = this.targets.findAll("toggable");

    toggable.forEach(function(element){
      element.classList.toggle('is-active');
    });
  }
}