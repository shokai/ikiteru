## notify-gyazz.com
## ikiteru notify plugin
## http://gyazz.com

### config
## notify : 
##  - name : 'gyazz'
##    title : 'ikiteru'
##    page : 'log'
##     => http://gyazz.com/ikiteru/log
##    basic_user : 'username' (optional)
##    basic_pass : 'password' (optional)

if status != :alive
  require 'gyazz'
  text = "#{addr} => [[[#{status}]]] [#{type}] at #{Time.now}"
  page = params['page']
  begin
    g = Gyazz.new(params['title'], params['basic_user'], params['basic_pass'])
    g.set(page, "#{g.get(page)}\n#{text}")
  rescue => e
    STDERR.puts e
  end
end
