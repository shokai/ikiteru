tools
=====

test http server
----------------

    % ruby httpd.rb
    % curl http://localhost:8080/status/200 # => return status 200
    % curl http://localhost:8080/status/500 # => return status 500
