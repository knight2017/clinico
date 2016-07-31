class AppointmentsController < ApplicationController

  def appointment_new
    @user = User.find params[:user_id]
    @doctors = @user.doctors
    @appointment = Appointment.new
    @appointment.user = @user
  end
  def appointment_create
    @user = User.find params[:user_id]
    @appointment = Appointment.new app_params
    @appointment.user = @user
  end

private
  def app_params
   app_params = params.require(:appointment).permit(:doctor_id, :start_time, :end_time)
  end




end
