document.addEventListener("turbo:load", () => {
  const bgm = document.querySelector("#bgm");

  // 保存されている再生状態を取得
  const wasPlaying = sessionStorage.getItem("wasPlaying") === "true";

  // 保存されている再生状態に基づいてBGMを再生または一時停止
  if (bgm) {
    if (wasPlaying) {
      bgm.play();
    } else {
      bgm.pause();
    }
  }

  // 再生と一時停止のイベントリスナーを追加し、再生状態を保存
  bgm.onplay = () => {
    sessionStorage.setItem("wasPlaying", "true");
  };

  bgm.onpause = () => {
    sessionStorage.setItem("wasPlaying", "false");
  };
});
