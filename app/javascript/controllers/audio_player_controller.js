import { Controller } from "@hotwired/stimulus";
import WaveSurfer from "wavesurfer.js";

// Connects to data-controller="audio-player"
export default class extends Controller {
  static values = { url: String };
  static targets = ["preview", "currentTime", "totalTime", "speedButton"];

  connect() {
    this.wavesurfer = WaveSurfer.create({
      container: this.previewTarget,
      waveColor: "#D1D5DB",
      progressColor: "#1A237E",
      url: this.urlValue,
    });

    this.wavesurfer.on("audioprocess", () => {
      this.updateProgress();
    });

    this.wavesurfer.on("ready", () => {
      this.updateTotalDuration();
    });

    // Detect when audio finishes
    this.wavesurfer.on("finish", () => {
      this.resetPlayPauseButton();
    });

    this.currentSpeedIndex = 0;
    this.speeds = [1, 1.25, 1.5, 2];
  }

  togglePlaying(e) {
    e.preventDefault(); // Prevent default link behavior
    this.wavesurfer.playPause();
    let link = e.target.closest("a");
    Array.from(link.children).forEach((child) =>
      child.classList.toggle("hidden")
    );
  }

  rewind(e) {
    e.preventDefault();  // Prevent page reload
    const currentTime = this.wavesurfer.getCurrentTime();
    this.wavesurfer.seekTo(Math.max((currentTime - 20) / this.wavesurfer.getDuration(), 0));
  }

  fastForward(e) {
    e.preventDefault();  // Prevent page reload
    const currentTime = this.wavesurfer.getCurrentTime();
    this.wavesurfer.seekTo(Math.min((currentTime + 20) / this.wavesurfer.getDuration(), 1));
  }

  updateProgress() {
    const currentTime = this.formatTime(this.wavesurfer.getCurrentTime());
    this.currentTimeTarget.textContent = currentTime;
  }

  updateTotalDuration() {
    const totalTime = this.formatTime(this.wavesurfer.getDuration());
    this.totalTimeTarget.textContent = totalTime;
  }

  changeSpeed() {
    this.currentSpeedIndex = (this.currentSpeedIndex + 1) % this.speeds.length;
    const newSpeed = this.speeds[this.currentSpeedIndex];
    this.wavesurfer.setPlaybackRate(newSpeed);
    this.speedButtonTarget.textContent = `${newSpeed}x`;
  }

  formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60).toString().padStart(2, "0");
    return `${minutes}:${secs}`;
  }

  resetPlayPauseButton() {
    let playButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:first-child');
    let pauseButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:last-child');

    // Ensure the play button is shown and pause button is hidden
    playButton.classList.remove("hidden");
    pauseButton.classList.add("hidden");
  }
}
