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

  anchor { 'begin_client': } ->
  class { 'apt_cacher_ng::client::config': } ->
  anchor { 'end_client': }

}
