class ApprovalsController < ApplicationController

  def create
    @doctor = Doctor.find params[:doctor_id]
    @approval = @doctor.approvals.new
    @approval.user = current_user
    respond_to do |format|
      if @approval.save
         @approval.submit
         @approval.save
        format.html { redirect_to display_path(@doctor), notice: "approval Created"}
        format.js { render :create_success }
      else
        format.html { render "/doctors/show"}
        format.js { render :create_failure }
      end
    end
  end
 def approval_patient
  @doctor = Doctor.find params[:doctor_id]
  @approval = Approval.find params[:id]
  @approval.approve
  @approval.save
  respond_to do |format|
    format.html{ redirect_to @doctor}
    format.js  {render}
  end
 end
 def decline_patient
   @doctor = Doctor.find params[:doctor_id]
   @approval = Approval.find params[:id]
   @approval.decline
   @approval.save
   respond_to do |format|
     format.html{ redirect_to @doctor}
     format.js  {render}
   end
 end

  private

  def approval_params
    params.require(:approval).permit(:title)
  end
end
