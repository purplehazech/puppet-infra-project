
class gentoo::rabe {
	exec {
		"add rabe repo to layman":
			command => "/usr/bin/layman -a rabe-portage-overlay",
			creates => "/var/lib/layman/rabe-portage-overlay/",
			require => Exec["sync layman repos"];
	}
}
