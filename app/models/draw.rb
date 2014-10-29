class Draw < ActiveRecord::Base

  include Appointable

  belongs_to :cup
  has_one :season, through: :cup

  validates :name, presence: true

  def competition
    cup
  end

end
