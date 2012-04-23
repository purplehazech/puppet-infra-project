
class gentoo::rabe {
	exec {
		"add rabe repo to layman":
			command => "/usr/bin/layman -a rabe",
			creates => "/var/lib/layman/rabe/",
			require => Exec["sync layman repos"]
	}
}
