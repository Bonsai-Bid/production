import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Start Turbo
Turbo.start()

// Start Stimulus
const application = Application.start()

// Dynamically import all Stimulus controllers in the controllers directory
const controllers = import.meta.glob("../controllers/**/*_controller.js", { eager: true })

// Log the imported controllers for debugging (you can remove this in production)
console.log(controllers);

// Register each controller with Stimulus
Object.entries(controllers).forEach(([path, controller]) => {
  const controllerName = path
    .split('/')                        // Split the path into parts
    .pop()                             // Get the file name (e.g., auction_controller.js)
    .replace('_controller.js', '')     // Remove the "_controller.js" suffix
    .replace(/_/g, '-')                // Convert underscores to dashes (for example, auction_controller -> auction)
  
  // Register the controller with Stimulus
  application.register(controllerName, controller.default)
})

// You can add any other global imports or initializations here
