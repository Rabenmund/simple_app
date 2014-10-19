class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true
  validates :perform_at, presence: true
end
