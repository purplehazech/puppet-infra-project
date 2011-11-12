Puppet Infra - Jenkins Module
=============================

The Jenkins module contains the integration platform that
does a lot of the heavy lifting pertaining to this project.

Module Coverage
---------------

This module mainly covers setting up the server and enables 
adding plugins.

Subclasses
----------
### Puppet

Placeholder to signifly that puppet --parseonly may be used
in builds. I hope to find more ways to get some testing done
on the basic puppet files.

### Github

Installs the github plugin in jenkins.

Operating Systems
-----------------

### Gentoo

Based on an external "untrusted" repo that doesnt carry the
latest version. The current production is based off the most
recent jenkins from upstream and some work on integrating
jenkins with a portage repo of our own is planned.

### CentOS

Support is planned.
