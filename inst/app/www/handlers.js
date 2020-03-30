$( document ).ready(function() {
  Shiny.addCustomMessageHandler('conf', function(arg) {
    var input = confirm(arg.message);
    Shiny.setInputValues(arg.id, input, {prority: "event"});
  });
  
  Shiny.addCustomMessageHandler('drive', function(arg) {
    var details = document.querySelectorAll("details");
    details.forEach((detail) => {detail.setAttribute("open", true)})
  })
});
