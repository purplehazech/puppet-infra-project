
class sudo::jenkins {

    file {
        "/etc/sudoers.d/jenkins_puppet":
            ensure  => file,
            owner   => root,
            mode    => 440,
            content => template("sudo/jenkins_puppet_sudoers.erb");

        "/usr/sbin/jenkins-recieve":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "/usr/bin/git archive --format=tar HEAD | (cd /etc/puppet/ && tar xf - )";
    }
}

