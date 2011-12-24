require 'rubygems'
require 'bundler/setup'
require File.dirname(__FILE__)+'/lib/loader'
require 'yaml'
require 'net/http'
require 'uri'

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
  if s['addr'].to_s.size < 1 or s['type'].to_s.size < 1
    s['status'] = :config_error
  elsif ikiteru?(s['addr'], s['type'])
    s['status'] = :alive
  else
    s['status'] = :dead
  end
  s
}

@@plugins.keys.each do |k|
  plugin = @@plugins[k]
  stats.each do |s|
    begin
      Ikiteru::Plugin::Notify.new(s).instance_eval plugin
    rescue SyntaxError => e
      STDERR.puts "plugin \"#{k}\" eval error!!"
      STDERR.puts e
    end
  end
end
