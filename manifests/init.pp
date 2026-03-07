# @summary Setup apt-cacher-ng proxy service
#
# @param version
#   Version tag passed to the package resource to specify an installed package
#   version.
# @param admin_user
#   Username for the admin account
# @param admin_pw
#   Password set for the admin account
#
class apt_cacher_ng (
  String $version = 'installed',
  Optional[String[1]] $admin_user = undef,
  Optional[String[1]] $admin_pw = undef,
) {
  $admin_info = [$admin_user, $admin_pw].filter |$v| { $v !~ Undef }
  if $admin_info.size() == 1 {
    fail('Please set either none or both of $admin_user and $admin_pw.')
  }

  contain apt_cacher_ng::install
  contain apt_cacher_ng::config
  contain apt_cacher_ng::service

  class { 'apt_cacher_ng::install': }
  -> class { 'apt_cacher_ng::config': }
  ~> class { 'apt_cacher_ng::service': }
}
