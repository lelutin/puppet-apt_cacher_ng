# This class should not be included directly. Users must use the `apt_cacher_ng`
# class.
#
# @summary Setup apt-cacher-ng service
#
# @api private
#
class apt_cacher_ng::service {

  service { 'apt-cacher-ng':
    ensure  => running,
  }

}
