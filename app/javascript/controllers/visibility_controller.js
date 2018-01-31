import { Controller } from "stimulus"

export default class extends Controller {
  toggle(evnt){
    event.preventDefault();

    const visibilities = this.targets.findAll("visibility");

    visibilities.forEach(function(element){
      element.classList.toggle('is-hidden');
    });
  }
}