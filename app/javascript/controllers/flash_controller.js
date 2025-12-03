import { Controller } from "@hotwired/stimulus"

// Controls auto-dismiss and manual closing of flash messages
export default class extends Controller {
  static values = {
    disappearAfter: { type: Number, default: 5000 }
  }

  connect() {
    if (this.disappearAfterValue > 0) {
      this.timeoutId = setTimeout(() => this.dismissAll(), this.disappearAfterValue)
    }
  }

  disconnect() {
    if (this.timeoutId) clearTimeout(this.timeoutId)
  }

  close(event) {
    const el = event.currentTarget.closest('[id^="flash-message-"]')
    if (el) this.fadeOut(el)
  }

  dismissAll() {
    this.element.querySelectorAll('[id^="flash-message-"]').forEach(el => this.fadeOut(el))
  }

  fadeOut(el) {
    el.style.opacity = '0'
    setTimeout(() => { el.style.display = 'none' }, 500)
  }
}
