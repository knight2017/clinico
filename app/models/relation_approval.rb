class RelationApproval < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor
end
