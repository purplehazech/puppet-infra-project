
class jenkins::puppet {

	package {
		"rspec":
			ensure => installed;
		"mocha":
			ensure => installed
	}
}
