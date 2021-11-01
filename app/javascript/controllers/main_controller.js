import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['main']
    static lozadLoaded = false

    connect() {
        this.init()
    }

    mainTargetConnected() {
        if (!this.lozadLoaded) {
            this.loadDefault()
        }
    }

    mainTargetDisconnected() {
        this.lozadLoaded = false
    }

    loadDefault() {
        window.dispatchEvent(new Event('reload'))
    }

    disconnect() {}

    initialize() {}

    init() {
        let self = this;
        self.navbarWillFixed(window.scrollY);
        window.addEventListener("scroll", function() {
            self.navbarWillFixed(window.scrollY);
        });
    }

    navbarWillFixed(scrollY) {
        if (scrollY >= 800) {
            document.getElementById("goTop").classList.add("showGoTop");
        }

        if (scrollY == 0) {
            document.getElementById("goTop").classList.remove("showGoTop");
        }
    }

    goTop(event) {
        event.preventDefault();
        window.scrollTo({ top: 0, behavior: "smooth" });
    }
}