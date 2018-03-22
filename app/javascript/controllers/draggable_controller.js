import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
  drag(event, target) {
    target.style.opacity = '0.4';

    this.drag_source = target

    event.dataTransfer.effectAllowed = 'move';
    event.dataTransfer.setData('text/html', target.innerHTML);
  }

  drag_enter(event, target) {
    target.classList.add('drag-over');
  }

  drag_leave(event, target) {
    target.classList.remove('drag-over');
  }

  drag_over(event) {
    event.preventDefault()
    event.dataTransfer.dropEffect = 'move'
    return false
  }

  drop(event, target) {
    event.preventDefault()
    if (this.drag_source != target) {
      this.drag_source.innerHTML = target.innerHTML;
      target.innerHTML = event.dataTransfer.getData('text/html');
    }
    return false
  }

  drag_end(event) {
    let draggables = this.targets.findAll('draggable')

    draggables.forEach(function(element, index) {
      element.setAttribute('data-order', index)
      element.style.opacity = '1'
      element.classList.remove('drag-over')
    })

    this.update_rails()
  }

  update_rails(id, index) {
    const draggables = this.targets.findAll('draggable')

    draggables.forEach(function(element){
      let order = element.dataset.order
      let id = element.firstElementChild.dataset.id

      axios.patch('/account/translations/order', {
        id: id,
        order: order
      })
      .then(response => {
        console.log('success')
      })
      .catch(error => {
        console.log('error', error)
      })
    });
  }
}