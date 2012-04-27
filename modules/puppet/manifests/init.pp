
class puppet {

    package { "puppet":
        ensure => installed
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

    # @todo: configure /etc/puppet here
}
