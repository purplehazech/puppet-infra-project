
class jenkins {

    package {
        "jenkins-bin":
            ensure  => installed,
            require => Package['ant']
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
    # @todo chmod -R g+w /etc/puppet/ /var/git/puppet/ && chgrp -R /etc/puppet/ /var/git/puppet
    service {
        "jenkins":
            ensure => running
    }
       
}

import "*.pp"
