module Ikiteru::Plugin
  class Watch
    attr_reader :addr, :type
    
    def initialize(params)
      @addr = params['addr']
      @type = params['type']
    end
  end
end

