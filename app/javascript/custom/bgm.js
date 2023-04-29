document.addEventListener("turbo:load", () => {
  const bgm = document.getElementById("bgm");
  const playPauseBtn = document.getElementById("playPauseBtn");

  bgm.volume = 0.1;

  playPauseBtn.addEventListener("click", () => {
    if (bgm.paused) {
      bgm.play();
      playPauseBtn.className = "bi bi-skip-end-btn";
    } else {
      bgm.pause();
      playPauseBtn.className = "bi bi-skip-end-btn";
    }
  });
});
