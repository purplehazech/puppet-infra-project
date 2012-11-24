# == Class: zabbix
#
# Install and configure zabbix agent on a system. This class is part of our default setup,
# we install the zabbix agent on every machine and configure them so send info to the
# server on a regular base. This is simply a classic active zabbix agent setup.
#
# === Parameters:
#
# [*zabbix_server_ip*]
#   where to reach the zabbix server instance, may also be a hostname but ips are recommended
#
# === Todos:
# * implement zabbix server with autoprovisioning based on resource collectors
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
