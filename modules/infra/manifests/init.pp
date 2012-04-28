import "*.pp"

class infra {

    package { "zabbix":
        ensure => installed
    }

    file { '/etc/zabbix/zabbix_agentd.conf':
        content => template("zabbix/zabbix_agentd.conf.erb")
    }

    service { "zabbix-agentd":
        ensure => running,
	require => [
            Package['zabbix'],
	    File['/etc/zabbix/zabbix_agentd.conf']
	]
    }

}
