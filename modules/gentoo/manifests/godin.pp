
class gentoo::godin {
	exec {
		"add godin repo to layman":
			command => "/usr/bin/layman -a godin",
			require => Exec["sync layman repos"]
	}
}
