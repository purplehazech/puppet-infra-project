
class puppet {

    package { "puppet":
        ensure => installed
    }

    service { "puppet":
        ensure => running,
	require => Package["puppet"]
    }

    # @todo: configure /etc/puppet here
}
