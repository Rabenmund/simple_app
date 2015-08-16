class Teardown < ActiveRecord::Base
  belongs_to :teardownable, polymorphic: true

  include Appointable

end
