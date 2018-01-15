document.addEventListener('turbolinks:load', function () {  
  (function(){
    let $burger = document.getElementById('burger');
    let target = $burger.dataset.target;
    let $target = document.getElementById(target);

    $burger.addEventListener('click', function(event){
      $burger.classList.toggle('is-active');
      $target.classList.toggle('is-active');
    });
  })();
});