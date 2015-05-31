class Contract < ActiveRecord::Base
  belongs_to :organization
  belongs_to :human
end
