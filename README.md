puppet-infra-project
====================

This is an implementation of github as a master puppet server.

This is a gentoo version of the article "Scaling Puppet with Git" 
[http://bitfieldconsulting.com/scaling-puppet-with-distributed-version-control].
I was thinking along the same lines and the blogpost helped speed up 
starting me on the implementation.

In this early stage all i do is setup a simple jenkins only stack that
has the tools needed to lint the puppetfiles that get pushed to github.

I forgot to mention:

* emerge puppet 
* wget https://raw.github.com/purplehazech/puppet-infra-project/master/bootstrap.pp
* puppet -v bootstrap.pp
* hostname gentoo-jenkins-dev
* puppet apply --modulepath=/etc/puppet/modules/ /etc/puppet/site.pp -v

should get you up and running when executed on a freshly installed gentoo build

