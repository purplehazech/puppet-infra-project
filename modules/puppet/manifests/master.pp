class puppet::master {

    require puppet

    package { 
	"puppet-infra-project": 
	    ensure => latest;
	"puppet-dashboard":
	    ensure => installed
    }

    service { "puppetmaster":
        ensure => running,
        require => [
	    Package["puppet-infra-project"]
        ]
    }
}
