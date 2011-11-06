
class gentoo::godin {
	exec {
		"add godin repo to layman":
			command => "/usr/bin/layman -s godin",
			require => Exec["sync layman repos"]
	}
}
