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
      $zabbix_agentd_service_name     = 'zabbix-agent'
      $zabbix_agentd_conf_file        = '/etc/zabbix/zabbix_agent.conf'
      $zabbix_agentd_conf_template    = 'zabbix_agentd.conf.erb'
      $zabbix_agentd_conf_include     = '/etc/zabbix/zabbix_agentd.d/'
      $zabbix_agentd_pid_file         = '/var/run/zabbix-agent/zabbix_agentd.pid'
      $zabbix_agentd_log_file         = '/var/log/zabbix-agent/zabbix_agentd.log'
    }
    default : {
      $zabbix_supports_userparameters = true
      $zabbix_agentd_install          = true
      $zabbix_agentd_package_name     = 'zabbix'
      $zabbix_agentd_service_name     = 'zabbix-agentd'
      $zabbix_agentd_conf_file        = '/etc/zabbix/zabbix_agentd.conf'
      $zabbix_agentd_conf_template    = 'zabbix_agentd.conf.erb'
      $zabbix_agentd_conf_include     = '/etc/zabbix/userparameter.d/'
      $zabbix_agentd_pid_file         = '/var/run/zabbix/zabbix_agentd.pid'
      $zabbix_agentd_log_file         = '/var/log/zabbix/zabbix_agentd.log'
    }
  }
}
