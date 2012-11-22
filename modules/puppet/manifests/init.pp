# == Class: puppet
#
# @todo rename $master to $puppet_master
class puppet inherits puppet::params {
  # @todo also change in win tpl
  $pluginsync = $puppet_pluginsync

  include gem

  if $puppet_install {
    if $puppet_hiera_gem {
      include puppet::hiera
    }
    package { 'puppet':
      ensure => installed
    }
  }

  if $master {
    include puppet::master
  }

  file { $puppet_conf_file:
    content => template("puppet/${puppet_conf_template}"),
    notify  => Service['puppet']
  }

  service { 'puppet':
    ensure  => running
  }
}
