import { Controller } from "stimulus"

export default class extends Controller {
  toggle(event) {
    const tabbable = this.targets.findAll("tabbable");
    const tabs= this.targets.findAll("tab");

    this.toggleTabbable(tabbable)
    this.toggleTabs(tabs)

    event.preventDefault();
  }

  toggleTabbable(tabbable) {
    tabbable.forEach(function(element){
      element.classList.toggle('is-hidden');
    });
  }

  toggleTabs(tabs) {
    tabs.forEach(function(element){
      element.classList.toggle('is-active');
    });
  }
}