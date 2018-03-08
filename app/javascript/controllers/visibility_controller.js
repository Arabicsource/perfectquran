import { Controller } from "stimulus"

export default class extends Controller {
  toggle(event){
    event.preventDefault();

    const visibilities = this.targets.findAll("toggable");

    visibilities.forEach(function(element){
      element.classList.toggle('is-hidden');
    });
  }
}