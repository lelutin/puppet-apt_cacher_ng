# This class should not be included directly. Users must use the `apt_cacher_ng`
# class.
#
# @summary Install apt-cacher-ng
#
# @api private
#
class apt_cacher_ng::install {

  package { 'apt-cacher-ng':
    ensure => $apt_cacher_ng::version,
  }

}
