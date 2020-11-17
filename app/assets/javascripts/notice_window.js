addEventListener('load', ()=> {
  const noticeWindow = document.getElementsByClassName("notice-window")[0];
  noticeWindowToggle();
  setTimeout(noticeWindowToggle, 3000)
  document.getElementsByClassName("notice-window--delete")[0].addEventListener('click', function() {
    noticeWindowToggle();
  });
  function noticeWindowToggle() {
    noticeWindow.classList.toggle("hidden");
  }
});
