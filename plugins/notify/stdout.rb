require 'rainbow'

print "[#{type}] #{addr} => "
if status == :alive
  color = :green
elsif status == :dead
  color = :red
else
  color = :magenta
end
puts "#{status}".color(color)
