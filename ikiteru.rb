require 'rubygems'
require 'bundler/setup'
require File.dirname(__FILE__)+'/lib/loader'
require 'yaml'

begin
  conf = YAML::load open(File.dirname(__FILE__)+'/config.yaml').read
rescue => e
  STDERR.puts e
  STDERR.puts "config.yaml load error!!"
end

def ikiteru?(addr, type, params)
  plugin = @@plugins[:watch][type.to_sym]
  begin
    Ikiteru::Plugin::Watch.new(addr, type, params).instance_eval plugin
  rescue SyntaxError => e
    STDERR.puts "plugin \"watch/#{k}\" eval error!!"
    STDERR.puts e
  end
end

stats = conf['watch'].map{|s|
  params = Hash.new
  s.each{|k,v|
    next if ['addr', 'type'].include? k
    params[k] = v
  }
  if s['addr'].to_s.size < 1 or s['type'].to_s.size < 1
    s['status'] = :config_error
  elsif ikiteru?(s['addr'], s['type'], params)
    s['status'] = :alive
  else
    s['status'] = :dead
  end
  s
}

@@plugins[:notify].keys.each do |k|
  plugin = @@plugins[:notify][k]
  stats.each do |s|
    begin
      Ikiteru::Plugin::Notify.new(s).instance_eval plugin
    rescue SyntaxError => e
      STDERR.puts "plugin \"notify/#{k}\" eval error!!"
      STDERR.puts e
    end
  end
end
