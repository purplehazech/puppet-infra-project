# == Class: infra
#
# This class contains common things we require on all machines that are
# under Puppet control.
#
# It gets added to all nodes by the external node classifier (ENC)
#
class infra {
  class { 'zabbix':
  }

  case $::operatingsystem {
    windows : {
    }
    default : {
      file { '/var/lib/infra':
        ensure => directory,
        mode   => '0755'
      }

    }

  }

}
