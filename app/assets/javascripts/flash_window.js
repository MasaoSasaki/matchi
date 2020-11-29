addEventListener('load', ()=> {
  const flashWindow = document.getElementsByClassName("flash-window")[0];
  flashWindowAdd();
  setTimeout(flashWindowRemove, 3000)
  document.getElementsByClassName("flash-window--delete")[0].addEventListener('click', flashWindowRemove);
  function flashWindowRemove() {
    flashWindow.classList.add("shut");
  }
  function flashWindowAdd() {
    flashWindow.classList.remove("shut");
  }
});
