import { Controller } from "stimulus"

export default class extends Controller {
  toggle() {
    const elements = this.targets.findAll("toggable");
    
    elements.forEach(function(element){
      element.classList.toggle('is-active');
    });
  }

  openBookmarksModal(event) {
    event.preventDefault();
    const element = this.targets.find('bookmarks-modal');
    element.classList.add('is-active');
  }

  closeBookmarksModal(event) {
    event.preventDefault();
    const element = this.targets.find('bookmarks-modal');
    element.classList.remove('is-active');
  }
}