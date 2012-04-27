class puppet::master {

    require puppet

    package { 
        "puppet": ;
	"puppet-infra-project": ;
    }

    service { "puppet":
        ensure => running,
        require => [
            Package["puppet"],
	    Package["puppet-infra-project"]
        ]
    }
}
