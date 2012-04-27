class gentoo::vnkuznet {
	exec {
		"add vnkuznet repo to layman":
			command => "/usr/bin/layman -a gentoo-vnkuznet-overlay",
			creates => "/var/lib/layman/gentoo-vnkuznet-overlay/",
			require => Exec["sync layman repos"]
	}
}
