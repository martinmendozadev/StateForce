import { Controller } from "@hotwired/stimulus"

// Controls the mobile sidebar <dialog>: open/close, outside click, Escape
export default class extends Controller {
  static targets = ["dialog", "panel", "backdrop"]

  connect() {
    this.handleDocumentKeydown = this.handleDocumentKeydown.bind(this)
    document.addEventListener("keydown", this.handleDocumentKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleDocumentKeydown)
  }

  open() {
    const dlg = this.dialogTarget
    if (typeof dlg.showModal === "function") {
      dlg.showModal()
    } else {
      dlg.setAttribute("open", "")
    }
    this.dialogTarget.dataset.open = "true"
  }

  close() {
    const dlg = this.dialogTarget
    if (typeof dlg.close === "function") {
      dlg.close()
    } else {
      dlg.removeAttribute("open")
    }
    delete this.dialogTarget.dataset.open
  }

  backdropClick(event) {
    // Click on backdrop should close
    if (event.target === this.backdropTarget) this.close()
  }

  outsideClick(event) {
    // If click is outside panel, close
    if (!this.panelTarget.contains(event.target)) this.close()
  }

  handleDocumentKeydown(event) {
    if (event.key === "Escape") {
      if (this.dialogTarget.hasAttribute("open")) this.close()
    }
  }
}
