
class jenkins::mantis {
	exec {
		"install mantis plugin":
			command => "/usr/bin/jenkins-cli -s http://$ipaddress:8080 install-plugin mantis",
			creates => "/var/lib/jenkins/home/plugins/mantis.hpi",
            require => File["/usr/bin/jenkins-cli"]
	}
}
