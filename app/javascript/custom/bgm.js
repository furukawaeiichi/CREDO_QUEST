document.addEventListener("turbo:load", function () {
  const bgm = document.getElementById("bgm");
  console.log(bgm);

  function playBGM() {
    console.log("Playing BGM");
    bgm.play();
  }

  // ページ全体のクリックイベントをリッスン
  document.addEventListener("click", function (event) {
    // 左クリックが押された場合
    if (event.button === 0) {
      playBGM();
    }
  });
});
