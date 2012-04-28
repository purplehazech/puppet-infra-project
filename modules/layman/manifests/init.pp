
class layman {

	package {
		"layman":
			ensure => installed
	}

	file {
		"/etc/layman/layman.cfg":
			ensure  => file,
			content => template("layman/gentoo_layman.cfg"),
			require => Package["layman"];
		"/etc/cron.daily/layman":
			content => "/usr/bin/layman -L && touch /var/lib/puppet/state/eix.stale",
			mode    => '0755';
	}

	exec {
		"sync layman repos":
			command => "/usr/bin/layman -L && touch /var/lib/puppet/state/eix.stale",
			onlyif  => "/bin/ls -al /var/lib/layman/cache*xml && exit 1 || exit 0",
			require => File["/etc/layman/layman.cfg"]
	}
	
}

