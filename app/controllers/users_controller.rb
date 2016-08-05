class UsersController < ApplicationController

  def new
    @user = User.new
  end
  def create
   user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.new user_params
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user, notice: "User added"
      else
        render :new
      end
  end
  def show
    @app_json = []
    @user = User.find params[:id]
    appointments = @user.appointments
    appointments.each do |appointment|
      if appointment.aasm_state == 'canceled'
        temp = {
         'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => 'black',
        }
      elsif appointment.aasm_state == 'submitted'
        temp = {
          'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => 'lightgray',
        }
      elsif appointment.aasm_state == 'confirmed'
        temp = {
         'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => '#0678be',
        }
      elsif appointment.aasm_state == 'rejected'
        temp = {
          'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => 'salmon',
        }
      elsif appointment.aasm_state == 'attended'
        temp = {
          'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => 'lightgreen'
        }
      elsif appointment.aasm_state == 'missed'
        temp = {
          'id'   => appointment.id,
         "title" =>"Dr. " + Doctor.find(appointment.doctor_id).full_name,
         "start" => appointment.start,
         'end'   => appointment.end,
         "color" => 'red',
        }
      end
     @app_json << temp
    end
    @app_json.flatten!
    respond_to do |format|
       format.html { render }
       format.json { render json: @app_json }
     end
  end

  def doctors
    @doctors = []
    user = User.find(params[:user_id])
    doctors = user.doctors
    doctorstype = ["Audiologist", "Allergist", "Anesthesiologist", "Cardiologist", "Endocrinologist"]
    doctorstype.each do |spc|
      temp =[]
      doctors.each do |doc|
        approval = Approval.find_by(doctor_id: doc.id, user_id: user.id)
        if (approval.aasm_state == 'approved')
          temp2 ={}
          if (doc.specializations.find_by_title spc)
            temp2 ={
              'id' => doc.id,
              'name' => doc.full_name
              }
            temp << temp2
          end
        end
      end
      hash = {spc => temp} if temp.length > 0
      @doctors << hash     if !hash.blank?
    end
    @doctors.flatten!
    respond_to do |format|
       format.html { render }
       format.json { render json: @doctors }
     end
  end


end
