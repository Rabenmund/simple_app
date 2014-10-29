class Draw < ActiveRecord::Base
  belongs_to :cup
  has_one :season, through: :cup
  has_one :appointment, as: :appointable

  validates :name, presence: true
end
