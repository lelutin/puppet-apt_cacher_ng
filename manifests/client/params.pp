# This class should not be included directly. Users must use the
# `apt_cacher_ng::client` class.
#
# @summary Parameter default values
#
# @api private
#
class apt_cacher_ng::client::params {
  $servers = ['127.0.0.1:3142']
  $autodetect = true
  $verbose = true
  $timeout = 30
}
