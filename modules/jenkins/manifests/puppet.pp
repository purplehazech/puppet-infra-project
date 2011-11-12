
class jenkins::puppet {

    include sudo::jenkins

    # i will be documenting my stuff using markdown
    include markdown

/**	not sure if i need these
	package {
		"rspec":
			ensure => installed;
		"mocha":
			ensure => installed
	}
*/

}
