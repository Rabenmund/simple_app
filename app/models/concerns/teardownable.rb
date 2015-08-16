module Teardownable
  extend ActiveSupport::Concern
  included do
    has_one :teardown, as: :teardownable
  end
end
