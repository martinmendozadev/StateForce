# app/controllers/users/instructions_controller.rb

class Users::InstructionsController < ApplicationController
  def instructions
    render template: "devise/registrations/instructions"
  end
end
