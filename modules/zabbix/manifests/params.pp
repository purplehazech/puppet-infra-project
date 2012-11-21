# == Class: zabbix::params
#
class zabbix::params {
  case $::operatingsystem {
    windows : {
      $zabbix_agentd_install          = false
      $zabbix_supports_userparameters = false
      $zabbix_agentd_service_name     = 'Zabbix Agent'
      $zabbix_agentd_conf_file        = 'C:\zabbix_agentd.conf'
      $zabbix_agentd_conf_template    = 'zabbix_agentd.win.conf.erb'
    }
    Debian  : {
      $zabbix_supports_userparameters = true
      $zabbix_agentd_install          = true
      $zabbix_agentd_package_name     = 'zabbix-agent'
      $zabbix_agentd_service_name     = 'zabbix-agentd'
      $zabbix_agentd_conf_file        = '/etc/zabbix/zabbix_agentd.conf'
      $zabbix_agentd_conf_template    = 'zabbix/zabbix_agentd.conf.erb'
    }
    default : {
      $zabbix_supports_userparameters = true
      $zabbix_agentd_install          = true
      $zabbix_agentd_package_name     = 'zabbix'
      $zabbix_agentd_service_name     = 'zabbix-agentd'
      $zabbix_agentd_conf_file        = '/etc/zabbix/zabbix_agentd.conf'
      $zabbix_agentd_conf_template    = 'zabbix/zabbix_agentd.conf.erb'
    }
  }
}
