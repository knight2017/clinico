class Specialization < ActiveRecord::Base
  has_many :tagging_Specializations, dependent: :destroy
  has_many :doctors, through: :tagging_Specializations
end
