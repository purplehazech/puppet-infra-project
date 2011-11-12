
class jenkins::github {
	exec {
		"install github plugin":
			command => "/usr/bin/jenkins-cli -s http://$ipaddress:8080 install-plugin github",
			creates => "/var/lib/jenkins/home/plugins/github.hpi",
            require => Service["jenkins"],
            notify  => Service["jenkins"]
	}
}
