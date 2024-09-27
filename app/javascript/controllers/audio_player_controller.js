import { Controller } from "@hotwired/stimulus";
import WaveSurfer from "wavesurfer.js";

export default class extends Controller {
  static values = { 
    url: String, 
    podcastId: Number, 
    episodeId: Number,
    savedProgress: Number
  };
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
      this.saveProgress();
    });
    this.wavesurfer.on("ready", () => {
      this.updateTotalDuration();
      this.loadSavedProgress();
    });
    this.wavesurfer.on("finish", () => {
      this.resetPlayPauseButton();
      this.markEpisodeAsPlayed();
      this.clearSavedProgress();
    });

    this.currentSpeedIndex = 0;
    this.speeds = [1, 1.25, 1.5, 2];

    // Set up periodic saving to server
    this.progressSaveInterval = setInterval(() => this.saveProgressToServer(), 30000); // Save every 30 seconds
  }

  disconnect() {
    this.wavesurfer.destroy();
    clearInterval(this.progressSaveInterval);
  }

  saveProgress() {
    const currentTime = this.wavesurfer.getCurrentTime();
    localStorage.setItem(`episode_progress_${this.episodeIdValue}`, currentTime.toString());
  }

  loadSavedProgress() {
    const savedTime = this.savedProgressValue || localStorage.getItem(`episode_progress_${this.episodeIdValue}`);
    if (savedTime) {
      this.wavesurfer.seekTo(parseFloat(savedTime) / this.wavesurfer.getDuration());
    }
  }

  clearSavedProgress() {
    localStorage.removeItem(`episode_progress_${this.episodeIdValue}`);
  }

  saveProgressToServer() {
    const currentTime = this.wavesurfer.getCurrentTime();
    fetch(`/podcasts/${this.podcastIdValue}/episodes/${this.episodeIdValue}/save_progress`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ progress: currentTime }),
    }).catch(error => console.error("Error saving progress:", error));
  }

  markEpisodeAsPlayed() {
    const podcastId = this.podcastIdValue;
    const episodeId = this.episodeIdValue;
  
    console.log("Podcast ID:", podcastId, "Episode ID:", episodeId); // Log values
    
    if (!podcastId || !episodeId) {
      console.error("Invalid podcast or episode ID");
      return;
    }

    fetch(`/podcasts/${podcastId}/episodes/${episodeId}/plays`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "text/vnd.turbo-stream.html",
      },
      body: JSON.stringify({ play: { episode_id: episodeId } }),
    })
    .then(response => {
      if (!response.ok) throw new Error("Network response was not ok");
      return response.text();
    })
    .then(data => Turbo.renderStreamMessage(data))
    .catch(error => {
      console.error("Error marking episode as played:", error);
      alert("Failed to mark episode as played. Please try again.");
    });
  }

  togglePlaying(event) {
    event.preventDefault();
    this.wavesurfer.playPause();
    this.updatePlayPauseButton();
  }

  rewind(event) {
    event.preventDefault();
    this.seekAudio(-20);
  }

  fastForward(event) {
    event.preventDefault();
    this.seekAudio(20);
  }

  seekAudio(seconds) {
    const currentTime = this.wavesurfer.getCurrentTime();
    this.wavesurfer.seekTo(Math.min(Math.max((currentTime + seconds) / this.wavesurfer.getDuration(), 0), 1));
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
    const playButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:first-child');
    const pauseButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:last-child');
    playButton.classList.remove("hidden");
    pauseButton.classList.add("hidden");
  }

  updatePlayPauseButton() {
    const playButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:first-child');
    const pauseButton = this.element.querySelector('svg[viewBox="0 0 24 24"]:last-child');
    if (this.wavesurfer.isPlaying()) {
      playButton.classList.add("hidden");
      pauseButton.classList.remove("hidden");
    } else {
      playButton.classList.remove("hidden");
      pauseButton.classList.add("hidden");
    }
  }
}