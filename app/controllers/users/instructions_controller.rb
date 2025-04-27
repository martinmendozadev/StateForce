# app/controllers/users/instructions_controller.rb

class Users::InstructionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && !@user.confirmed?
      @user.send_confirmation_instructions
      redirect_to new_user_session_path, notice: "Te hemos enviado un correo de confirmación."
    else
      flash.now[:alert] = "No pudimos encontrar un usuario no confirmado con ese correo."
      @user = User.new
      render :new
    end
  end

  def instructions
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
end
