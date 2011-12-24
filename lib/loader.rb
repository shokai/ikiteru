module Ikiteru
end

Dir.glob("#{File.dirname(__FILE__)}/../lib/plugin_*.rb").each do |rb|
  require rb
end

@@plugins = Hash.new{|h,k|h[k] = Hash.new}

[:watch, :notify].each do |category|
  Dir.glob("#{File.dirname(__FILE__)}/../plugins/#{category}/*.rb").each do |rb|
    name = rb.scan(/([^\/]+).rb$/).first.first.to_sym
    @@plugins[category][name] = open(rb).read
  end
end
