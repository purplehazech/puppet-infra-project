# == Class: zabbix:agent::params
#
define zabbix::agent::params ($ensure = 'present', $params) {
  if $zabbix::params::zabbix_supports_userparameters {
    file { $zabbix::params::zabbix_agentd_conf_include:
      ensure => directory,
      notify => Service[$zabbix::params::zabbix_agentd_service_name]
    }
  }

  # @todo traverse params hash and create lots of param nodes
}
