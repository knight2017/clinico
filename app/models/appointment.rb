class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor


  include AASM
  aasm whiny_transitions: false do
    state :submitted, initial: true
    state :confirmed
    state :rejected
    state :canceled
    state :attended
    state :missed

    event :confirm do
      transitions from: :submitted, to: :confirmed
    end
    event :reject do
      transitions from: :submitted, to: :rejected
    end

    event :cancel do
      transitions from: :confirmed, to: :canceled
    end

    event :attend do
      transitions from: :confirmed, to: :attended
    end

    event :miss do
      transitions from: :confirmed, to: :missed
    end
  end
end
