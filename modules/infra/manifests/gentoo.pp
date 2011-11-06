
class infra::gentoo {
	package {
		"layman":
			ensure => installed
	}

	file {
		"/etc/layman/layman.cfg":
			ensure  => file,
			content => template("infra/gentoo_layman.cfg"),
			require => Package["layman"]
	}

	exec {
		"sync layman repos":
			command => "/usr/bin/layman -L",
			creates => "/var/lib/layman/something",
			require => File["/etc/layman/layman.cfg"
	}
}
