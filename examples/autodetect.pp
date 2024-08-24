class { 'apt_cacher_ng::client':
  # server     => "192.168.31.42:3142",
  servers    => ['192.168.31.41:3142', '192.168.31.42:3142'],
  verbose    => false,
  autodetect => true,
}
