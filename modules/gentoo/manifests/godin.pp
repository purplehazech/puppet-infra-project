
class gentoo::godin {
	package {
		# needed for syncing godwin overlay
		# will move this incantation to a nicer location when i configure svn
		"subversion":
			ensure => installed,
	}
	exec {
		"add godin repo to layman":
			command => "/usr/bin/layman -a godin",
			require => Exec["sync layman repos"]
	}
}
