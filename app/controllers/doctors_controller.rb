class DoctorsController < ApplicationController

  def new
    @doctor = Doctor.new
  end
  def create
   doctor_params = params.require(:doctor).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @doctor = Doctor.new doctor_params
      if @doctor.save
        session[:doctor_id] = @doctor.id
        redirect_to @doctor, notice: "Doctor added"
      else
        render :new
      end
  end
  def edit
    @doctor = Doctor.find params[:id]
  end
  def patients
    doctor = Doctor.find(params[:id])
    users = doctor.approved_users
    respond_to do |format|
       format.html { render }
       format.json { render json: users}
     end
  end

  def update
    doctor_update = params.require(:doctor).permit(:first_name, :last_name, :email, :location, :information, {specialization_ids: []})
    @doctor = Doctor.find params[:id]
    if @doctor.update(doctor_update)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @doctor = Doctor.find params[:id]
    @approval = @doctor.approvals.new
  end

  def index
    @doctors = Doctor.all
    defaultlocation = [49.2827, 123.1207]
    @mapdoctors = Doctor.near("Vancouver, BC", 400, units: :km)
    @abc = Gmaps4rails.build_markers(@mapdoctors) do |doctor, marker|
      marker.lat        doctor.latitude
      marker.lng        doctor.longitude
      marker.infowindow doctor.first_name
    end
  end

  def display
    @doctor = Doctor.find params[:id]
    @approval = @doctor.approvals.new
    respond_to do |format|
       format.html { render }
       format.json { render json: @doctor}
     end

  end



end
