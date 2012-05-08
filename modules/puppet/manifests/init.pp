
class puppet {

    package {
        "puppet":
            ensure => installed,
	    before => Service['puppet'];

    }

    file { "/etc/puppet/puppet.conf":
	content => template("puppet/puppet.conf.erb")
    }

    service { "puppet":
        ensure => running,
	require => [
	    File["/etc/puppet/puppet.conf"]
	]
    }

    file {
        "/etc/cron.daily/eix-update":
	    content => '',
	    mode    => '0755'
    }
}
