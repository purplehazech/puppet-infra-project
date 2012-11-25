# == Class: puppet::master
#
# Class responsible for installing and configuring the puppet master.
#
class puppet::master inherits puppet::params {
  include puppet::storeconfig

  case $puppet_master_infra_version {
    latest : {
      package { 'puppet-infra-project': ensure => latest }
      $puppet_master_infra_resource = Package['puppet-infra-project']
    }
    'git'  : {
      # @todo implement autosyncing
      $puppet_master_infra_resource = []
    }
  }

  if $puppet_master_infra_resource {
    $puppet_service_require = [File[$puppet_conf_file], $puppet_master_infra_resource]
  } else {
    $puppet_service_require = File[$puppet_conf_file]
  }

  service { 'puppetmaster':
    ensure  => running,
    require => $puppet_service_require
  }

}

# EOF
