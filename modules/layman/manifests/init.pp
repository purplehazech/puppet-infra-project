# == Class: layman
#
# Install and manage layman
#
# === Parameters
# [*ensure*]
#   installed
# [*sync*]
#   true lets layman vserver sync to /var/lib/layman, default, false uses a readonly mount in /var/lib/infra/layman
#
# === Example Usage
#
#  layman {'layman':}
#
class layman ($ensure = installed, $sync = false) inherits layman::params {
  if $sync {
    # rw layman dir
    $layman_dir = '/var/lib/layman'
  } else {
    # ro mount for dependant systems
    $layman_dir = '/var/lib/infra/layman'
  }

  package { 'layman': ensure => $ensure }

  # register repos to install
  layman::repository { $layman_cfg_overlays: }

  file { $laymap_cfg_file:
    ensure  => file,
    content => template('layman/gentoo_layman.cfg.erb'),
    require => Package['layman'];
  }

  file {
    '/var/lib/infra/layman':
      ensure  => directory
  }

  file {
    '/var/lib/layman':
      ensure => directory,
      mode   => '0555';

    '/var/lib/layman/make.conf':
      ensure => file,
      mode   => '0555';
  }

  schedule { 'layman-daily':
    period => daily,
    range  => '2-4'
  }

  exec { 'update-layman-cfg-overlays':
    command  => '/usr/bin/layman -S && touch /var/lib/puppet/state/eix.stale',
    onlyif   => "/bin/ls -al ${layman_dir}/cache*xml && exit 1 || exit 0",
    require  => File['/etc/layman/layman.cfg'],
    schedule => layman-daily
  }
}

