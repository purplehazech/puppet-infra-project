
class jenkins {

	package {
		"jenkins-bin":
			ensure => installed,
		"ant":
			ensure => installed
	}

	file {

		"/usr/bin/jenkins-cli":
			ensure  => file,
			content => "java -jar /usr/lib/jenkins/jenkins-cli.jar \$@",
			mode    => 555
	}
	exec {
		"/usr/lib/jenkins/jenkins-cli.jar":
			cwd     => "/tmp",
			command => "/usr/bin/jar -xvf /usr/lib/jenkins/jenkins.war WEB-INF/jenkins-cli.jar && mv WEB-INF/jenkins-cli.jar /usr/lib/jenkins/",
			creates => "/usr/lib/jenkins/jenkins-cli.jar"
	}
}

import "*.pp"
