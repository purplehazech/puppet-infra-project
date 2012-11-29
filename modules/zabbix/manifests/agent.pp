# == Class: zabbix::agent
#
# Manage a zabbix agent
#
class zabbix::agent inherits zabbix::params {
  file { $zabbix_agentd_conf_file:
    content => template("zabbix/${zabbix_agentd_conf_template}"),
    notify  => Service[$zabbix_agentd_service_name];
  }

  if $zabbix_agentd_install {
    package { $zabbix_agentd_package_name:
      ensure => installed,
      before => File[$zabbix_agentd_conf_file]
    }
    $zabbix_service_require = Package[$zabbix_agentd_package_name]
  }

  if $zabbix_supports_userparameters {
    file { $zabbix_agentd_conf_include:
      ensure => directory,
      notify => Service[$zabbix_agentd_service_name]
    }
  }

  service { $zabbix_agentd_service_name:
    ensure  => running,
    require => $zabbix_service_require
  }

}

