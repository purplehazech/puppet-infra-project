class zabbix {

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
