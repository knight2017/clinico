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
  end
  def display
    @doctor = Doctor.find params[:id]
    @approval = @doctor.approvals.new
  end



end
