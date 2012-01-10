require 'rubygems'
require File.dirname(__FILE__)+'/lib/loader'
require 'yaml'

conf_fname = ARGV.first ? ARGV.shift : File.dirname(__FILE__)+'/config.yaml'

begin
  conf = YAML::load open(conf_fname).read
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

conf['notify'].each do |n|
  next if n['name'].to_s.size < 1
  name = n['name'].to_sym
  unless @@plugins[:notify].keys.include? name
    STDERR.puts "plugin \"notify/#{n['name']}\" not installed!!"
    next
  end
  plugin = @@plugins[:notify][name]
  params = Hash.new
  n.each{|k,v|
    next if k == 'name'
    params[k] = v
  }
  stats.each do |s|
    begin
      Ikiteru::Plugin::Notify.new(s, params).instance_eval plugin
    rescue SyntaxError => e
      STDERR.puts "plugin \"notify/#{k}\" eval error!!"
      STDERR.puts e
    end
  end
end
