
class jenkins::puppet {

    include sudo::jenkins

/**	not sure if i need these
	package {
		"rspec":
			ensure => installed;
		"mocha":
			ensure => installed
	}
*/

}
