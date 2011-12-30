module Ikiteru::Plugin
  class Notify
    attr_reader :addr, :type, :status, :params
    
    def initialize(result, params)
      @addr = result['addr']
      @type = result['type']
      @status = result['status']
      @params = params
    end
  end
end
