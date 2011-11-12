
class sudo::jenkins {

    file {
        "/etc/sudoers.d/jenkins_puppet":
            ensure  => file,
            owner   => root,
            mode    => 440,
            content => template("sudo/jenkins_puppet_sudoers.erb");

        "/usr/sbin/jenkins-receive":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "cd /var/git/puppet && /usr/bin/git archive --format=tar HEAD | (cd /etc/puppet/ && tar xf - )";

        "/usr/sbin/puppet-apply":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "/usr/bin/puppet apply --modulepath=/etc/puppet/modules/ /etc/puppet/site.pp -v --color html"
    }
}

