Puppet Infra - Sudo Module
==========================

The sudo module contains the setup needed by other modules.

Module Coverage
---------------

Wrappers Scripts, Aliases for basic sudo integration with a
planned focus on ldap.

Subclasses
----------
### Jenkins

The things needed by jenkins for automatic integration down
to applying puppet on target systems.

### Ldap

Setup of all things related to ldap.

Operating Systems
-----------------

I believe sudo should be cross-platform safe in the way i
intend to use it.

### Gentoo

Simple sudoers.d support based on OS sudo.

### CentOS

Needs checking.
