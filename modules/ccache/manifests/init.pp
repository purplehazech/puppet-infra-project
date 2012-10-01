class ccache {

	package { 'ccache':
		ensure => installed
	}
	
	service { 'ccache':
		ensure => running
	}

	Service['ccache'] -> Package['ccache']
}
