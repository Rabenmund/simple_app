require 'active_support/hash_with_indifferent_access'

class MethodicalHash
  def initialize(hash)
    @hash = ActiveSupport::HashWithIndifferentAccess.new(hash)
  end

  def method_missing(name, *args, &blk)
    if args.empty? && blk.nil? && @hash.has_key?(name.to_s)
      @hash[name.to_s]
    else
      super
    end
  end
end
