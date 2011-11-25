import "*.pp"

class infra {

    file {
        # do this in jenkins after bootstrap!
        "/var/git/puppet/hooks/post-receive":
            ensure  => empty;

        # these scripts get registered with sudo in sudo::jenkins
        "/usr/sbin/jenkins-receive":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "cd /var/git/puppet && /usr/bin/git archive --format=tar HEAD | (cd /etc/puppet/ && tar xf - ) ; exit $?";

        "/usr/sbin/puppet-apply":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "/usr/bin/puppet apply --modulepath=/etc/puppet/modules/ /etc/puppet/site.pp -v --color false; exit $?"
    }

}
