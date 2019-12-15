$( document ).ready(function() {
  function watchColorPicker(event) {
    document.querySelectorAll("p").forEach(function(p) {
      p.style.color = event.target.value;
    });
  }
});