import "*.pp"

class infra {

    file {
        "/var/git/puppet/hooks/post-receive":
            ensure  => file,
            owner   => git,
            group   => jenkins,
            mode    => 775,
            content => "sudo /usr/sbin/jenkins-receive",
    }

}
