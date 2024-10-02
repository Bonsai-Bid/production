// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import CategoryVisibilityController from "./category_visibility_controller"
import FormSubmissionController from "./form_submission_controller"
import AttributeInitializationController from "./attribute_initialization_controller"

application.register("hello", HelloController)
application.register("category-visibility", CategoryVisibilityController)
application.register("form-submission", FormSubmissionController)
application.register("attribute-initialization", AttributeInitializationController)