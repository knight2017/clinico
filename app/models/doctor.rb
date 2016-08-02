class Doctor < ActiveRecord::Base
  has_secure_password
  has_many :approvals, dependent: :destroy
  has_many :approved_users, through: :approvals, source: :user
  has_many :availabilities, dependent: :destroy
  has_many :tagging_Specializations, dependent: :destroy
  has_many :specializations, through: :tagging_Specializations
  has_many :appointments, dependent: :destroy
  has_many :booked_users, through: :appointments, source: :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  def full_name
    "#{first_name} #{last_name}"
  end

  def approved(user)
    approvals.exists?(user:user)
  end

end
