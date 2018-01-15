document.addEventListener('turbolinks:load', function () {  
  (function(){
    let $opener = document.getElementById('bookmarks-modal-opener');
    let target = $opener.dataset.target;
    let $target = document.getElementById(target);

    $opener.addEventListener('click', function(event){
      event.preventDefault();
      $target.classList.toggle('is-active');
    });
  })();

  (function(){
    let $closer = document.getElementById('bookmarks-modal-closer');
    let target = $closer.dataset.target;
    let $target = document.getElementById(target);
  
    $closer.addEventListener('click', function(event){
      event.preventDefault();
      $target.classList.toggle('is-active');
    });
  })();
});