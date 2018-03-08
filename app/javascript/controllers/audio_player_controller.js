import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    this.audio = new Audio(this.targets.find('src').dataset.src)
    this.progress = this.targets.find('progress')

    const that = this
    this.audio.addEventListener('loadedmetadata', function() {
      that.progress.setAttribute('max', that.audio.duration)
    });
  }

  disconnect() {
    this.stop()
  }

  play(event) {
    const play_button = this.targets.find('play-button')
    play_button.classList.add('is-hidden')

    const pause_button = this.targets.find('pause-button')
    pause_button.classList.remove('is-hidden')

    this.audio.play()

    const that = this
    this.interval_id = setInterval(function () {
      that.progress.setAttribute('value', that.audio.currentTime)
      if (that.audio.ended) {
        that.stop()
      }
    }, 100);

    event.preventDefault()
  }


  pause(event) {
    const play_button = this.targets.find('play-button')
    play_button.classList.remove('is-hidden')

    const pause_button = this.targets.find('pause-button')
    pause_button.classList.add('is-hidden')

    this.audio.pause()
    clearInterval(this.interval_id)

    event.preventDefault()
  }

  loop() {
    const loop_checkbox = this.targets.find('loop')
    this.audio.loop = loop_checkbox.checked
  }

  seek(event) {
    let percent = event.offsetX / this.progress.offsetWidth
    let progress_value = this.audio.duration * percent

    this.audio.currentTime = progress_value
    this.progress.setAttribute('value', progress_value)
  }

  stop() {
    this.audio.pause()
    this.audio.currentTime = 0
    this.progress.setAttribute('value', 0)
    clearInterval(this.interval_id)

    const play_button = this.targets.find('play-button')
    play_button.classList.remove('is-hidden')

    const pause_button = this.targets.find('pause-button')
    pause_button.classList.add('is-hidden')
  }

  transliteration(event) {
    const transliteration = this.targets.find('transliteration')
    transliteration.classList.toggle('is-hidden')
    event.preventDefault()
  }

  translation(event) {
    const translation = this.targets.find('translation')
    translation.classList.toggle('is-hidden')
    event.preventDefault()
  }
}