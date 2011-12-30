## notify-skype
## ikiteru notify plugin
## https://github.com/shokai/skype-chat-gateway-mac
## or https://github.com/shokai/skype-chat-gateway-linux

### config
## notify : 
##  - name : 'skype'
##    url : 'http://localhost:8787/'

if status != :alive
  require 'net/http'
  require 'uri'

  begin
    uri = URI.parse params['url']
    Net::HTTP.start(uri.host, uri.port) do |http|
      http.post(uri.path, "<ikiteru> [#{type}] #{addr} => #{status}")
    end
  rescue => e
    STDERR.puts e
  end
end
