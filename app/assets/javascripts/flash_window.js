addEventListener('load', ()=> {
  const flashWindow = document.getElementsByClassName("flash-window")[0];
  flashWindowToggle();
  setTimeout(flashWindowToggle, 3000)
  document.getElementsByClassName("flash-window--delete")[0].addEventListener('click', flashWindowToggle);
  function flashWindowToggle() {
    flashWindow.classList.toggle("hidden");
  }
});
