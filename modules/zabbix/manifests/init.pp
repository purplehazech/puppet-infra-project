class zabbix {

    case $::operatingsystem {
        windows: {
            file {
                'C:\zabbix_agentd.conf':
                   content => template("zabbix/zabbix_agentd.win.conf.erb"),
                   subscribe => Service['Zabbix Agent'];
            }
            service {
                'Zabbix Agent':
                    ensure => running
            }
        }
        default: {
            package { "zabbix":
                ensure => installed
            }

            file {
                '/etc/zabbix/zabbix_agentd.conf':
                   content => template("zabbix/zabbix_agentd.conf.erb");
                '/etc/zabbix/userparameter.d':
                   ensure => directory;
            }
            service { "zabbix-agentd":
                ensure => running,
                    require => [
                    Package['zabbix'],
                    File['/etc/zabbix/zabbix_agentd.conf']
                ]
            }
        }
    }

}
