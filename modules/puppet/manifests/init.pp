
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

    # trigger eix-update when it is marked as stale by the file
    # /var/lib/puppet/state/eix.stale. This is meant to be used
    # as an external trigger source. I shall add created this 
    # file after building new versions of the infra on jenkins
    # to puppetmaster since i sont want to wait for cron on 
    # that machines. i'll wait for this till i have an esb and
    # do such stuff by hand for now.

    exec { 
        "rm-eix-stalefile":
            command => "/bin/rm -f /var/lib/puppet/state/eix.stale",
	    onlyif => "/usr/bin/test -f /var/lib/puppet/state/eix.stale";

        "/usr/bin/eix-update":
	    unless => "/usr/bin/test ! -f /var/lib/puppet/state/eix.stale",
            require => [
	        Service["puppet"],
		Exec["sync layman repos"],
	        Exec['rm-eix-stalefile']
	    ]
    }

    file {
        "/etc/cron.daily/eix-update":
	    ensure => '/usr/bin/eix-update',
	    require => [
	        Exec["sync layman repos"],
	        Exec['rm-eix-stalefile']
	    ]
    }
}
