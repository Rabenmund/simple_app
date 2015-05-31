class Profession < ActiveRecord::Base
  belongs_to :human
  belongs_to :professionable, polymorphic: true
end
