ikiteru
=======
watch service status and notify.


Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Config
------

    % cp sample.config.yaml config.yaml

edit it.


Run
---

    % ruby ikiteru.rb


Plugins
-------

you can put plugins in "plugin/(watch|notify)" directory.

* watch -> check status -> notify
