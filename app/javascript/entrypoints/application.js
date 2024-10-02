import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Start Turbo
Turbo.start()

// Start Stimulus
const application = Application.start()

// Dynamically import all Stimulus controllers
const controllers = import.meta.glob("../controllers/**/*_controller.js", { eager: true })
Object.entries(controllers).forEach(([path, controller]) => {
  const controllerName = path
    .split('/')
    .pop()
    .replace('_controller.js', '')
    .replace(/_/g, '-')
  application.register(controllerName, controller.default)
})

// You can add any other global imports here