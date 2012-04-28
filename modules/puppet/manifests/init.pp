
class puppet {

    package {
        "puppet":
            ensure => installed;
        "eix":
	    ensure => installed;
    }

    file { "/etc/puppet/puppet.conf":
	content => template("puppet/puppet.conf.erb")
    }

    service { "puppet":
        ensure => running,
	require => [
	    Package["puppet"],
	    File["/etc/puppet/puppet.conf"]
	]
    }

    exec { "eix-update":
        require => [
	    ["puppet"]
	]
    }
}
