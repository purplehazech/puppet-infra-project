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
class layman ($ensure = installed, $sync = false) {
  package { 'layman': ensure => $ensure }

  if $sync {
    # rw layman dir
    $layman_dir = '/var/lib/layman'
  } else {
    # ro mount for dependant systems
    $layman_dir = '/var/lib/infra/layman'
  }

  file {
    '/etc/layman/layman.cfg':
      ensure  => file,
      content => template('layman/gentoo_layman.cfg'),
      require => Package['layman'];

    '/etc/cron.daily/layman':
      content => '/usr/bin/layman -S',
      mode    => '0755';

    '/var/lib/infra/layman':
      ensure => directory;

    '/var/lib/layman':
      ensure => directory,
      mode   => '0555';

    '/var/lib/layman/make.conf':
      ensure => file,
      mode   => '0555';
  }

  exec { 'sync layman repos':
    command => '/usr/bin/layman -L && touch /var/lib/puppet/state/eix.stale',
    onlyif  => "/bin/ls -al ${layman_dir}r}/cache*xml && exit 1 || exit 0",
    require => File['/etc/layman/layman.cfg']
  }
}
# EOF
