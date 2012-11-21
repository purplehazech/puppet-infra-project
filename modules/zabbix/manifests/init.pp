# == Class: zabbix
#
# === Parameters:
#
# [*zabbix_server_ip*]
#   where to reach the zabbix server instance, may also be a hostname but ips are recommended
#
class zabbix inherits zabbix::params {
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
    file { '/etc/zabbix/userparameter.d': ensure => directory; }
  }

  service { $zabbix_agentd_service_name:
    ensure  => running,
    require => $zabbix_service_require
  }
}
