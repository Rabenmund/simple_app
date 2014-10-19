class Draw < ActiveRecord::Base
  belongs_to :cup
  has_one :season, through: :cup
  has_one :event, as: :eventable

  validates :name, presence: true
end
