import "*.pp"

class infra {

    package { "zabbix":
        ensure => installed
    }

    file { '/etc/zabbix/zabbix_agentd.conf':
        contents => template("zabbix/agentd.conf")
    }

    service { "zabbix-agentd":
        ensure => running,
	require => [
            Package['zabbix'],
	    File['/etc/zabbix/zabbix_agentd.conf']
	]
    }

}
