## notify-im.kayac.com
## ikiteru notify plugin
## gem install im-kayac

### config
## notify : 
##  - name : 'im-kayac'
##    user : 'your-name'
##    sig : 'your-api-signature' # (optional)
##    password : 'your-api-password' # (optional)

if status != :alive
  require 'im-kayac'
  message = "<ikiteru> [#{type}] #{addr} => #{status}"

  if params['sig']
    require 'digest/sha1'
    auth = {:sig => Digest::SHA1.hexdigest(message + params['sig'])}
  elsif params['password']
    auth = {:password => params['password']}
  else
    auth = nil
  end
  begin
    ImKayac.post(params['user'], message, auth)
  rescue => e
    STDERR.puts e
  end
end
