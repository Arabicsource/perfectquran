import Tooltip from 'tooltip.js'


document.addEventListener('turbolinks:load', function() {
  (function(){
    const elements = document.querySelectorAll('[data-tooltip]');

    Array.prototype.map.call(elements, function(element){
      new Tooltip(element, {
        trigger: "hover"
     });
    });
  })();
});