# @summary Configure host as a proxy client
#
# @param servers
#   List of proxy servers used by the client apt. Setting more than one value is
#   only useful when `autodetect` is set to true.
# @param autodetect
#   If true, the apt client will try all $servers in turn and use the first one
#   that responds.
# @param verbose
#   If false, proxy autodetection will not be logged. Only useful if `autodetect`
#   is set to true.
# @param timeout
#   Number of seconds after which a proxy is considered unresponsive during
#   autodetection. This parameter is unused when `autodetect` is set to false.
#
class apt_cacher_ng::client (
  Array[String[1], 1] $servers = $apt_cacher_ng::client::params::servers,
  Boolean $autodetect = $apt_cacher_ng::client::params::autodetect,
  Boolean $verbose = $apt_cacher_ng::client::params::verbose,
  Integer[1] $timeout = $apt_cacher_ng::client::params::timeout
) inherits apt_cacher_ng::client::params {
  if (! $autodetect) and (count($servers) > 1) {
    fail('With $autodetect turned off, you can only specify one server.')
  }

  contain apt_cacher_ng::client::config
}
