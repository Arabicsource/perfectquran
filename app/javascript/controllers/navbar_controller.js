import { Controller } from "stimulus"

export default class extends Controller {
  toggle_menu() {
    const burger = this.targets.find('burger')
    const menu = this.targets.find('menu')

    burger.classList.toggle('is-active')
    menu.classList.toggle('is-active')
  }

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

  hideAudio(event) {
    const audio = this.targets.find('audio');
    audio.classList.toggle('is-hidden');

    event.preventDefault();
  }
}