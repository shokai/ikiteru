module Ikiteru::Plugin
  class Notify
    attr_reader :addr, :type, :status
    
    def initialize(params)
      @addr = params['addr']
      @type = params['type']
      @status = params['status']
    end
  end
end
