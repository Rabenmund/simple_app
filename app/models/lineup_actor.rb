class LineupActor < ActiveRecord::Base
  belongs_to :lineup
  belongs_to :actorable, polymorphic: true
end
