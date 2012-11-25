# == Class: puppet
#
# Install puppet on a box
#
# === Parameters:
# [*puppet_server*]
#   where to find the puppetmaster (defaults to puppet)
# [*puppet_master*]
#   set to true if the box is a master
#
class puppet inherits puppet::params {
  # @todo also change in win tpl
  $pluginsync = $puppet_pluginsync

  include gem

  if $puppet_install {
    if $puppet_hiera_gem {
      include puppet::hiera
    }

    package { 'puppet': ensure => installed }
  }

  if $puppet_master {
    include puppet::master

    if $puppet_master_install_dashboard {
      include puppet::dashboard

    }
  }

  file { $puppet_conf_file:
    content => template("puppet/${puppet_conf_template}"),
    notify  => Service['puppet']
  }

  service { 'puppet': ensure => running }
}

