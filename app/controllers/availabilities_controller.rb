class AvailabilitiesController < ApplicationController

def index
@doctor = Doctor.find params[:doctor_id]
@app_json = []
availabilities = @doctor.availabilities
availabilities.each do |availability|
  temp = {
   'id'   => availability.id,
   "title" =>"open for booking",
   "start" => availability.start,
   'end'   => availability.end,
  #  "color" => COLOUR[red]
  }
@app_json << temp
end
@app_json.flatten!
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

def destroy
end

private
def avail_params
  params.require(:availability).permit(:doctor_id, :start, :end)

end


end
