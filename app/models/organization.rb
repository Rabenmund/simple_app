class Organization < ActiveRecord::Base
  has_many :contracts
  has_many :humen, through: :contracts
  belongs_to :organizable, polymorphic: true
end
