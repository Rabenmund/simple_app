class Human < ActiveRecord::Base
  has_many :contracts
  has_many :organizations, through: :contracts
  has_many :professions
end

