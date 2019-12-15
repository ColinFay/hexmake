$(document).ready(function(){
  /* FROM https://stackoverflow.com/questions/16751345/automatically-close-all-the-other-details-tags-after-opening-a-specific-detai */
  const details = document.querySelectorAll("details");
  details.forEach((targetDetail) => {
    targetDetail.addEventListener("click", () => {
      details.forEach((detail) => {
        if (detail !== targetDetail) {
          detail.removeAttribute("open");
        }
      });
    });
  });
});