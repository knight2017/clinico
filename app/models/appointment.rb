class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor


  include AASM
  aasm whiny_transitions: false do
    state :upcoming, initial: true
    state :canceled
    state :attended
    state :missed

    event :cancel do
      transitions from: :upcoming, to: :canceled
    end

    event :attend do
      transitions from: :submitted, to: :attended
    end

    event :miss do
      transitions from: :submitted, to: :missed
    end
  end
end
