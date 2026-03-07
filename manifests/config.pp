# This class should not be included directly. Users must use the `apt_cacher_ng`
# class.
#
# @summary Configure apt-cacher-ng service
#
# @api private
#
class apt_cacher_ng::config {

  file { '/etc/apt-cacher-ng/acng.conf':
    source => [
      "puppet:///modules/site_apt_cacher_ng/${::fqdn}/acng.conf",
      'puppet:///modules/site_apt_cacher_ng/acng.conf',
      'puppet:///modules/apt_cacher_ng/acng.conf'
    ],
  }

  file { '/var/cache/apt-cacher-ng':
    ensure  => directory,
    owner   => 'apt-cacher-ng',
  }

  $admin_user = $apt_cacher_ng::admin_user
  $admin_pw = $apt_cacher_ng::admin_pw
  file { '/etc/apt-cacher-ng/security.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'apt-cacher-ng',
    mode    => '0640',
    content => template('apt_cacher_ng/security.conf.erb'),
  }

}
