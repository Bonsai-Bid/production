import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Start Turbo
Turbo.start()

// Start Stimulus
const application = Application.start()

// Dynamically import all Stimulus controllers in the controllers directory
const controllers = import.meta.glob("../controllers/stimulus/**/*_controller.js", { eager: true })


// Log the imported controllers for debugging (you can remove this in production)
console.log(controllers);

// Register each controller with Stimulus
Object.entries(controllers).forEach(([path, controller]) => {
  const controllerName = path
    .split('/')
    .pop()
    .replace('_controller.js', '')
    .replace(/_/g, '-');

  // Log the controller to check if any are undefined or missing default export
  if (!controller || !controller.default) {
    console.error(`Controller at ${path} is not properly exporting a default class.`);
  } else {
    application.register(controllerName, controller.default);
  }
});


// You can add any other global imports or initializations here
