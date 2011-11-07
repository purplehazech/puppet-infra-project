
class jenkins::github {
	exec {
		"install github plugin":
			command => "/usr/bin/jenkins-cli -s http://localhost:8080 install-plugin github"
	}
}
