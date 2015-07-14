class Human < ActiveRecord::Base
  has_many :contracts
  has_many :organizations, through: :contracts
  has_many :professions

  def age
    (LogicalDate.date-birthday).to_i
  end
end

