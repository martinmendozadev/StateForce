import { Controller } from "@hotwired/stimulus"

// Closes a <details> dropdown on outside click and Escape key
export default class extends Controller {
  static targets = ["panel"]

  connect() {
    this.handleDocumentClick = this.handleDocumentClick.bind(this)
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("click", this.handleDocumentClick, true)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("click", this.handleDocumentClick, true)
    document.removeEventListener("keydown", this.handleKeydown)
  }

  toggle(event) {
    // optional: could be used if we switch to button
  }

  handleDocumentClick(event) {
    const details = this.element
    if (!details.hasAttribute("open")) return

    if (details.contains(event.target)) return

    details.removeAttribute("open")
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      const details = this.element
      if (details.hasAttribute("open")) {
        details.removeAttribute("open")
        const summary = details.querySelector("summary")
        if (summary) summary.focus()
      }
    }
  }
}
