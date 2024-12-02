import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.element.addEventListener("focusin", this.#setPermanent)
    this.element.addEventListener("focusout", this.#unsetPermanent)
    this.element.addEventListener("turbo:before-frame-render", this.#copyPermanence)
  }

  disconnect() {
    this.element.removeEventListener("focusin", this.#setPermanent)
    this.element.removeEventListener("focusout", this.#unsetPermanent)
    this.element.removeEventListener("turbo:before-frame-render", this.#copyPermanence)
  }

  refresh(e) {
    this.formTarget.action = this.formTarget.action + "?refresh_form=1"
    this.formTarget.requestSubmit()
  }

  #setPermanent(e) {
    const el = e.target.closest(".input")
    if (el) el.setAttribute("data-turbo-permanent", true)
  }

  #unsetPermanent(e) {
    const el = e.target.closest(".input")
    if (el) el.removeAttribute("data-turbo-permanent")
  }

  #copyPermanence(e) {
    for(const currentPermanentElement of e.target.querySelectorAll("[id][data-turbo-permanent]")) {
      const newPermanentElement = e.detail.newFrame.querySelector(`#${currentPermanentElement.id}`)
      if (newPermanentElement) newPermanentElement.dataset.turboPermanent = true
    }
  }
}
