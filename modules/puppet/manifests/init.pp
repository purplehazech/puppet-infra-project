# == Class: puppet
#
class puppet inherits puppet::params {
  $pluginsync = $puppet_pluginsync

  include gem

  service { 'puppet':
    ensure  => running,
    require => File[$puppet_conf_file]
  }

  file { $puppet_conf_file:
    content => template("puppet/${puppet_conf_template}"),
    notify  => Service['puppet']
  }

  if $puppet_install {
    if $puppet_hiera_gem {
      include puppet::hiera
    }
    package { 'puppet':
      ensure => installed
    }
  }
}
