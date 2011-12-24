require 'uri'
require 'net/http'

uri = URI.parse URI.encode(addr)
begin
  Net::HTTP.start(uri.host, uri.port) do |http|
    return http.get(uri.path).code == '200'
  end
rescue
  return false
end
false
