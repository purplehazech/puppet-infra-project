class puppet::master {

    require puppet

    package { 
	"puppet-infra-project": 
	    ensure => latest
    }

    service { "puppetmaster":
        ensure => running,
        require => [
	    Package["puppet-infra-project"]
        ]
    }
}
