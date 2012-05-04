
class puppet {

    package {
        "puppet":
            ensure => installed.
            # i had to patch /usr/lib64/ruby/site_ruby/1.8/puppet/provider/package/portage.rb
            # to make it support a different EIX_CACHEFILE
            noop => true;
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

    file {
        "/etc/cron.daily/eix-update":
	    content => '',
	    mode    => '0755'
    }
}
