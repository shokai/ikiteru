## http status
## ikiteru watch plugin

### config
## watch :
##   - addr : 'http://example.com/auth'
##     type : 'http'
##     basic_user : 'username'
##     basic_pass : 'password'

require 'uri'
require 'net/http'

uri = URI.parse URI.encode(addr)
begin
  req = Net::HTTP::Get.new uri.path
  if params['basic_user'] and params['basic_pass']
    req.basic_auth(params['basic_user'], params['basic_pass'])
  end
  Net::HTTP.start(uri.host, uri.port) do |http|
    res = http.request req
    return res.code == '200'
  end
rescue
  return false
end
false
