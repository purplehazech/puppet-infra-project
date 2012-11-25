# == Class: puppet::storeconfig
#
# install routes.yaml and delegate to actual storeconfig implementation
#
class puppet::storeconfig inherits puppet::params {
  case $puppet_storeconfig_provider {
    'puppetdb'     : {
      $puppet_storeconfig_install = true
      include puppet::puppetdb
    }
    'activerecord' : {
      $puppet_storeconfig_install = false
      include puppet::activerecord
    }
    default        : {
      $puppet_storeconfig_install = false
    }
  }

  if $puppet_storeconfig_install {
    file { '/etc/puppet/routes.yaml':
      content => template('puppet/routes.yaml.erb'),
      notify  => Service['puppetmaster']
    }
  }
}
