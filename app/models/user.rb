class User < ActiveRecord::Base
  has_secure_password
  has_many :approvals, dependent: :destroy
  has_many :doctors, through: :approvals
  has_many :appointments, dependent: :destroy
  has_many :booked_doctors, through: :appointments, source: :doctor
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  def full_name
    "#{first_name} #{last_name}"
  end
  def current_doctor_relation(doctor)
   state = approvals.find_by_doctor_id(doctor.id)
   if state
     state.aasm_state
   else
     "not applied"
   end
  end

end
