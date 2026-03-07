# This class should not be included directly. Users must use the apt_cacher_ng
# class.
#
# @summary Setup single-server proxy client configuration
#
# @api private
#
# @param ensure
#   Set to absent to remove configuration files.
#
class apt_cacher_ng::client::one_proxy (
  $ensure = present
) {

  $server = $apt_cacher_ng::client::servers[0]
  file { '/etc/apt/apt.conf.d/71proxy':
    ensure  => $ensure,
    content => "Acquire::http { Proxy \"http://${server}\"; };",
    owner   => 'root',
    group   => 0,
    mode    => '0644',
  }

}
