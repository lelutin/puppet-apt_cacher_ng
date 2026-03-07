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
  $servers = $apt_cacher_ng::client::params::servers,
  $autodetect = $apt_cacher_ng::client::params::autodetect,
  $verbose = $apt_cacher_ng::client::params::verbose,
  $timeout = $apt_cacher_ng::client::params::timeout
) inherits apt_cacher_ng::client::params {

  validate_array($servers)
  if empty($servers) {
    fail('$servers must contain at least one value.')
  }
  if (! $autodetect) and (count($servers) > 1) {
    fail('With $autodetect turned off, you can only specify one server.')
  }
  validate_bool($autodetect)
  validate_bool($verbose)
  if !is_integer($timeout) {
    fail('Parameter $timeout is expected to be an integer value.')
  }

  anchor { 'apt_cacher_ng::client::begin': } ->
  class { 'apt_cacher_ng::client::config': } ->
  anchor { 'apt_cacher_ng::client::end': }

}
