## http content diff
## ikiteru watch plugin

### config
## watch :
##   - addr : 'http://example.com/auth'
##     type : 'http_content_diff'
##     memcache : 'localhost:11211'
##     expire : 600
##     basic_user : 'username'
##     basic_pass : 'password'

require 'uri'
require 'net/http'
require 'memcached'

cache_addr = params['memcache'] ? params['memcache'] : 'localhost:11211'
expire = params['expire'] ? params['expire'] : 600
cache = Memcached.new(cache_addr)
key = "http_content_diff_#{URI.encode addr}"

uri = URI.parse URI.encode(addr)
begin
  req = Net::HTTP::Get.new uri.path
  if params['basic_user'] and params['basic_pass']
    req.basic_auth(params['basic_user'], params['basic_pass'])
  end
  Net::HTTP.start(uri.host, uri.port) do |http|
    res = http.request req
    stat = cache.get(key) != res.body rescue stat = true
    cache.set(key, res.body, expire)
    return stat
  end
rescue => e
  STDERR.puts e
  return false
end
false
