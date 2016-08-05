class AppointmentsController < ApplicationController

  def appointment_new
    @user = User.find params[:user_id]
    @doctors = @user.doctors
    @appointment = Appointment.new
    @appointment.user = @user
  end
  def create
    @appointment = Appointment.new app_params
    availability = Availability.find(params[:avail_id])
    availability.book
    availability.save
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

      if appointment.cancel_pre_conf
        appointment.save
        head :ok
      else
        render :appointment_new
      end
    elsif appointment.aasm_state == 'confirmed'
       if appointment.cancel
         appointment.save
         head :ok
       else
         render :appointment_new
       end
    end
  end
  def confirm
    con_params = params.require(:appointment).permit(:app_id)
    appointment = Appointment.find(params[:id])
    if appointment.confirm
      appointment.save
       head :ok
    else
       head 500
    end
  end

  def reject
    appointment = Appointment.find(params[:id])
    if appointment.reject
       appointment.save
       head :ok
    else
       head 500
    end
  end
  def miss
    appointment = Appointment.find(params[:id])
    if appointment.miss
      appointment.save
       head :ok
    else
       head 500
    end
  end

  def attend
    appointment = Appointment.find(params[:id])
    if appointment.attend
       appointment.save
       head :ok
    else
       head 500
    end
  end





private
  def app_params
   params.require(:appointment).permit(:user_id, :doctor_id, :start, :end)
  end




end
