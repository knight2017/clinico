class AppointmentsController < ApplicationController

  def appointment_new
    @user = User.find params[:user_id]
    @doctors = @user.doctors
    @appointment = Appointment.new
    @appointment.user = @user
  end
  def create
    @appointment = Appointment.new app_params
    if @appointment.save
      head :created
    else
      render :appointment_new
    end
  end
  def cancel
    can_params  = params.require(:appointment).permit(:id)
    appointment = Appointment.find(can_params[:id])
    if appointment.aasm_state == 'submitted'
        appointment.cancel_pre_conf
    elsif appointment.aasm_state == 'confirmed'
       appointment.cancel
    end
    if appointment.save
      head :ok
    else
      render :appointment_new
    end
  end

private
  def app_params
   params.require(:appointment).permit(:user_id, :doctor_id, :start, :end)
  end




end
