class Availability < ActiveRecord::Base
  belongs_to :doctor

  include AASM
  aasm whiny_transitions: false do
    state :open, initial: true
    state :booked
    state :closed

    event :book do
      transitions from: :open, to: :booked
    end
    event :close do
      transitions from: :open, to: :closed
    end
    event :reopen do
      transitions from: :closed, to: :open
    end
  end
end
