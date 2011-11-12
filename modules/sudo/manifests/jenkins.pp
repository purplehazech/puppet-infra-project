
class sudo::jenkins {

    file {
        "/etc/sudoers.d/jenkins_puppet":
            ensure  => exists,
            content => template("sudo/jenkins_puppet_sudoers.erb");

        "/usr/sbin/jenkins-recieve":
            ensure  => exists,
            content => "/usr/bin/git archive --format=tar HEAD | (cd /etc/puppet/ && tar xf - )",
            owner   => root,
            mode    => 500
    }
}

