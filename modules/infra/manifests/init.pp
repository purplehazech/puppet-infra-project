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
	    content => 'export TEMPREPO=/tmp/jenkins-receive-$PPID; echo $TEMPREPO; git clone --recursive file:///var/git/puppet $TEMPREPO && cd $TEMPREPO && tar -c . | (cd /etc/puppet/ && tar xf - && rm -rf $TEMPREPO); exit $?';

        "/usr/sbin/puppet-apply":
            ensure  => file,
            owner   => root,
            mode    => 500,
            content => "/usr/bin/puppet apply --modulepath=/etc/puppet/modules/ /etc/puppet/site.pp -v --color false; exit $?"
    }

}
