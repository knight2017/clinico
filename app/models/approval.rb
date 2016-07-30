class Approval < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor


  include AASM
  aasm whiny_transitions: false do
    state :unapproved, initial: true
    state :submitted
    state :declined
    state :approved

    event :submit do
      transitions from: :unapproved, to: :submitted
    end

    event :decline do
      transitions from: :submitted, to: :declined
    end

    event :approve do
      transitions from: :submitted, to: :approved
    end
  end

end
