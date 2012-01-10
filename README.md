ikiteru
=======
watch service status and notify.


Install Dependencies
--------------------

install gems for plugins

    % gem install rainbow

install gems more (optional)

    % gem install memcached im-kayac gyazz


Config
------

    % cp sample.config.yaml config.yaml

edit it.


Run
---

    % ruby ikiteru.rb


Test
----

    % ruby ikiteru.rb test.config.yaml

Plugins
-------

you can put plugins in "plugin/(watch|notify)" directory.

* watch -> check status -> notify
