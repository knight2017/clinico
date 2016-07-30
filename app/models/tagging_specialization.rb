class TaggingSpecialization < ActiveRecord::Base
  belongs_to :specialization
  belongs_to :doctor
end
