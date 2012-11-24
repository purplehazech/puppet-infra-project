# == Class: puppet::puppetdb
#
# install and setup a puppetdb instance for each master
#
class puppet::puppetdb inherits puppet::params {
  package { ['puppetdb', 'puppetdb-terminus']:
    ensure => installed,
    before => Service['puppetdb']
  }

  service { 'puppetdb':
    ensure  => running,
    require => File[$puppet_puppetdb_config_file],
    notify  => Service['puppetmaster']
  }

  file { $puppet_puppetdb_config_file: content => template("puppet/${puppet_puppetdb_config_template}") }
}
