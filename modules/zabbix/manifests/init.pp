class zabbix {

    package { "zabbix":
        ensure => installed
    }

    file {
        case $::operatingsystem {
            gentoo: {
                '/etc/zabbix/zabbix_agentd.conf':
                   content => template("zabbix/zabbix_agentd.conf.erb");
                '/etc/zabbix/userparameter.d':
                   ensure => directory;
            }
            windows: {
                'C:\zabbix_agentd.conf':
                   content => template("zabbix/zabbix_agentd.win.conf.erb");
            }
        }
    }

    case $::operatingsystem {
        windows: {
        },
        default: {
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
