class SessionsController < ApplicationController
  def new
    @user = User.new
    @doctor = Doctor.new
  end

  def create
     user = User.find_by_email params[:email]
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect_to  root_path, notice: "hello"
     else
       redirect_to  root_path, notice: "wrong information"
     end
  end
  def create_doctor
     doctor = Doctor.find_by_email params[:email]
     if doctor && doctor.authenticate(params[:password])
       session[:doctor_id] = doctor.id
       redirect_to  root_path, notice: "hello"
     else
       redirect_to  root_path, notice: "wrong information"
     end
  end

  def destroy
    session[:user_id] = nil
    session[:doctor_id] = nil
    redirect_to root_path, notice: "signed out"
  end

end
