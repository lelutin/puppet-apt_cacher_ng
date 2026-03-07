# This class should not be included directly. Users must use the apt_cacher_ng
# class.
#
# @summary Setup proxy autodetection for proxy client
#
# @api private
#
# @param ensure
#   Set to absent to remove configuration files.
#
class apt_cacher_ng::client::autodetect (
  $ensure = present
) {

  file { '/etc/apt/apt.conf.d/30detectproxy':
    ensure => $ensure,
    source => 'puppet:///modules/apt_cacher_ng/30detectproxy',
    owner  => 'root',
    group  => 0,
    mode   => '0644',
  }

  $show_proxy_messages = bool2num($apt_cacher_ng::client::verbose)

  $proxies = $apt_cacher_ng::client::servers

  file { '/etc/apt/detect-http-proxy':
    ensure  => $ensure,
    content => template('apt_cacher_ng/detect-http-proxy.erb'),
    owner   => 'root',
    group   => 0,
    mode    => '0755',
  }
  file { '/etc/apt/proxy.conf':
    ensure  => $ensure,
    content => template('apt_cacher_ng/apt-proxy-conf.erb'),
    owner   => 'root',
    group   => 0,
    mode    => '0644',
  }

}
