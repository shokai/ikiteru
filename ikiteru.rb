require 'rubygems'
require 'yaml'
require 'net/http'
require 'uri'
require 'rainbow'

begin
  conf = YAML::load open(File.dirname(__FILE__)+'/config.yaml').read
rescue => e
  STDERR.puts e
  STDERR.puts "config.yaml load error!!"
end

def ikiteru?(addr, type)
  if type == 'ping'
    return system "ping -c 1 #{addr} > /dev/null 2>&1"
  elsif type == 'http'
    uri = URI.parse addr
    begin
      Net::HTTP.start(uri.host, uri.port) do |http|
        return http.get(uri.path).code == '200'
      end
    rescue
      return false
    end
  end
  false
end

stats = conf['services'].map{|s|
  s['status'] = ikiteru?(s['addr'], s['type'])
  s
}

stats.each do |s|
  print "[#{s['type']}] #{s['addr']} => "
  if s['status']
    puts "alive".color(:green)
  else
    puts "dead".color(:red)
  end
end
