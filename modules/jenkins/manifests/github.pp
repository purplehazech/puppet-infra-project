
class jenkins::github {
	exec {
		"install github plugin":
			command => "/usr/bin/jenkins-cli -s http://localhost:808 install-plugin github"
	}
}
