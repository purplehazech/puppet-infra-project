# == Class: puppet::activerecord
#
# storeconfigs in activerecord
#
class puppet::activerecord inherits puppet::params {
  package { $puppet_storeconfig_activerecord_packages: ensure => present }

}

