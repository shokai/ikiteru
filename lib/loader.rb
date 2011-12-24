module Ikiteru
end

Dir.glob("#{File.dirname(__FILE__)}/../lib/plugin_*.rb").each do |rb|
  puts "load #{rb}"
  require rb
end

@@plugins = Hash.new

[:watch, :notify].each do |category|
  Dir.glob("#{File.dirname(__FILE__)}/../plugins/#{category}/*.rb").each do |rb|
    puts "load #{rb}"
    name = rb.scan(/([^\/]+).rb$/).first.first
    @@plugins[name] = open(rb).read
  end
end
