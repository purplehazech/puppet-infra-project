class puppet::master {

    require puppet

    package { 
        "puppet": ;
	"puppet-infra-project": ;
    }

    service { "puppetmaster":
        ensure => running,
        require => [
            Package["puppet"],
	    Package["puppet-infra-project"]
        ]
    }
}
