
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
    
    jenkins::plugin {
        "analysis-core":
            ensure => present;
        "analysis-collector":
            ensure => present;
    }
}

# define for installing plugins in a puppety manner
define jenkins::plugin(
    $name
){

    # only install when requested, i'll add uninstall cases later
    case $ensure {
        present: {

            # install plugin on cli
            exec { "install jenkins plugin ${name}":
                command => "/usr/bin/jenkins-cli -s http://$ipaddress:8080 install-plugin $name",
                creates => "/var/lib/jenkins/home/plugins/$name.hpi",
                require => [
                    File["/usr/binm/jenkins-cli"]
                ]
            }
        }
    }
}

import "*.pp"
