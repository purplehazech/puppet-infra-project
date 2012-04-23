
class gentoo::rabe {
	line { 'layman-overlays':
		file => '/etc/make.conf',
		line => 'source /var/lib/layman/make.conf',
	},
	exec {
		"add rabe repo to layman":
			command => "/usr/bin/layman -a rabe",
			creates => "/var/lib/layman/rabe/",
			require => Line['sync layman repos']
	}
}
