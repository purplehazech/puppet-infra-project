puppet-infra-project
====================

This is an implementation of github as a master puppet server.

This is a gentoo version of the article "Scaling Puppet with Git" 
[http://bitfieldconsulting.com/scaling-puppet-with-distributed-version-control].
I was thinking along the same lines and the blogpost helped speed up 
starting me on the implementation.

In this early stage all i do is setup a simple jenkins only stack that
has the tools needed to lint the puppetfiles that get pushed to github.
