module Ikiteru::Plugin
  class Watch
    attr_reader :addr, :type, :params
    
    def initialize(addr, type, params={})
      @addr = addr
      @type = type
      @params = params
    end
  end
end

