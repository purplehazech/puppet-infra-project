class layman {
  package { 'layman': ensure => installed }

  # reposync is the only machine that has a rw layman dir
  # @todo refactor this so reposync-01 isn't in here
  #

  if $hostname == 'reposync-01' {
    $layman_dir = '/var/lib/layman'
  } else {
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
    require => File['tc/layman/layman.cfg"]']
  }
}
# EOF 