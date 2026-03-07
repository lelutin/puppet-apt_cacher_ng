# puppet-apt_cacher_ng

A Puppet module for installing and configuring [apt-cacher-ng].

Requires puppetlabs [stdlib] module

Original author: [Alban Peignier]

Other contributors:

* [Garth Kidd]: Vagrantfile and smoke tests (not used anymore)
* [Gabriel Filion]: version specification, file layout flexibility
* [Lekensteyn]: auto-detect/fallback script (see [askubuntu:54099])

## Usage

The apt\_cacher\_ng module provides two main "entry points": one for the server
and one for clients.

### Server

The main class, `apt_cacher_ng` will install the apt_cacher_ng server. You can
simply include the class, or if you want to install a specific version you can
use the `version` parameter like the following:

```puppet
class { 'apt_cacher_ng':
  version => '0.4.6-1ubuntu1',
}
```

* The server will be available on the default port (3142).
* The server will not use itself as a cache by default.

If you'd like to set an admin password for the web interface, you can do so
with the `admin_user` and `admin_pw` parameters. Make sure to set both
parameters (or none). Also, keep in mind that only alphanumeric characters,
dashes and underscores are accepted for the password:

```puppet
class { 'apt_cacher_ng':
  admin_user => 'clown_goose',
  admin_pw   => '12tgDd23456ytGfDW32',
}
```

### Client

The class `apt_cacher_ng::client` helps you configure a server as a client
for an apt proxy. It has two "modes" of configuration: setting up one proxy
with no alternative, and setting up a list of proxies where the first in the
list that is currently available will be used (autodetection).

Both modes use the `servers` parameter to the `apt_cacher_ng::client` class.
This parameter should be an array that contains server strings. The servers
strings are fqdn (or IP address) and port in the same mannger as you'd write
it for HTTP, without the "http://" prefix.

* To setup one proxy with no fallback, set the `autodetect` parameter to
  `false` and make sure to provide only one server value for the `servers`
  parameter:

    ```puppet
    class { 'apt_cacher_ng::client':
      servers    => ['192.168.31.42:3142'],
      autodetect => false,
    }
    ```

  Per [askubuntu:54099], you'll need to do this on older Ubuntu and Debian
  releases. Lucid and Squeeze support `Acquire::http::ProxyAutoDetect`;
  Karmic and Lenny don't.

* To setup a list of proxies, keep the `autodetect` paramter to a value of
  `true` (this is the default value) and specify all servers in the `servers`
  parameter:

    ```puppet
    class { 'apt_cacher_ng::client':
      servers => ['192.168.30.42:3142', '192.168.31.42:3142'],
    }
    ```

  When setting up autodetect, you can override the number of seconds till
  timeout (default is 30):

    ```puppet
    class { 'apt_cacher_ng::client':
      servers => ['192.168.30.42:3142', '192.168.31.42:3142'],
      timeout => 15,
    }
    ```

  Also when setting up autodetect, you can set the `verbose` parameter to
  `false` to make the autodetection process act quietly:

    ```puppet
    class { 'apt_cacher_ng::client':
      servers => ['192.168.30.42:3142', '192.168.31.42:3142'],
      verbose => false,
    }
    ```

[apt-cacher-ng]: http://www.unix-ag.uni-kl.de/~bloch/acng/
[stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[Alban Peignier]: https://github.com/albanpeignier
[Garth Kidd]: https://github.com/garthk
[Gabriel Filion]: https://github.com/lelutin
[Lekensteyn]: http://www.lekensteyn.nl/
[askubuntu:54099]: http://askubuntu.com/a/54099
