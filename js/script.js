(function() {
  document.querySelector('.mobile-menu-button').addEventListener("click", function(){
    this.classList.toggle("open");
    document.querySelector('.js-overlay').classList.toggle("visible");
    document.querySelector('.main-menu').classList.toggle("open");
  }, false);
})();