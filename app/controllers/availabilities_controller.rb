class AvailabilitiesController < ApplicationController

  def user_view_avail
  @doctor = Doctor.find params[:doctor_id]
  @app_json = []
  availabilities = @doctor.availabilities
  availabilities.each do |availability|
    if availability.aasm_state =='open'
      temp = {
       'id'    => availability.id,
       "title" => "open for booking",
       "start" => availability.start,
       'end'   => availability.end,
       'name'  => @doctor.full_name,
       'icon'  => "open"
      }
    end
    @app_json << temp
  end
  @app_json.compact!
   respond_to do |format|
     format.html { render }
     format.json { render json: @app_json }
   end
  end








def index
@doctor = Doctor.find params[:doctor_id]
@app_json = []
appointments =  @doctor.appointments
availabilities = @doctor.availabilities
availabilities.each do |availability|
  if availability.aasm_state =='open'
    temp = {
     'id'    => availability.id,
     "title" => "open for booking",
     "start" => availability.start,
     'end'   => availability.end,
     'name'  => @doctor.full_name,
     'icon'  => "open"
    }
  elsif availability.aasm_state =='closed'
    temp = {
     'id'    => availability.id,
     "title" => "closed for booking",
     "start" => availability.start,
     'end'   => availability.end,
     'name'  => @doctor.full_name,
     'color' => 'orange',
     'icon'  => "closed"
    }
  end
  @app_json << temp
end
appointments.each do |appointment|
  if appointment.aasm_state == 'canceled'
    temp = {
     'id'      => appointment.id,
     'user_id' => appointment.user_id,
     "title" =>User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => 'black',
     'icon'  => "canceled"
    }
  elsif appointment.aasm_state == 'submitted'
    temp = {
     'id'   => appointment.id,
     'user_id' => appointment.user_id,
     "title" =>User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => 'lightgray',
     'icon'  => "submitted"
    }
  elsif appointment.aasm_state == 'confirmed'
    temp = {
     'id'   => appointment.id,
     'user_id' => appointment.user_id,
     "title" =>User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => '#0678be',
     'icon'  => "confirmed",
     'faicon' => "ban"
    }
  elsif appointment.aasm_state == 'rejected'
    temp = {
     'id'   => appointment.id,
     'user_id' => appointment.user_id,
     "title" =>User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => 'salmon',
     'icon'  => "rejected"
    }
  elsif appointment.aasm_state == 'attended'
    temp = {
     'id'   => appointment.id,
     'user_id' => appointment.user_id,
     "title" =>User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => 'lightgreen',
     'icon'  => "attended"
    }
  elsif appointment.aasm_state == 'missed'
    temp = {
     'id'   => appointment.id,
     'user_id' => appointment.user_id,
     "title" => User.find(appointment.user_id).full_name,
     "start" => appointment.start,
     'end'   => appointment.end,
     "color" => 'red',
     'icon'  => "missed"
    }
  end
 @app_json << temp
end
@app_json.compact!
 respond_to do |format|
   format.html { render }
   format.json { render json: @app_json }
 end
end

def create
  @doctor = Doctor.find params[:doctor_id]
  @availability = Availability.new avail_params
  if @availability.save
    head :created
  else
    render :index
  end
end

def close
  avail = Availability.find(params[:id])
  if avail.close
    avail.save
     head :ok
  else
     head 500
  end
end
def reopen
  avail = Availability.find(params[:id])
  if avail.reopen
    avail.save
     head :ok
  else
     head 500
  end
end

private
def avail_params
  params.require(:availability).permit(:doctor_id, :start, :end)
end


end
