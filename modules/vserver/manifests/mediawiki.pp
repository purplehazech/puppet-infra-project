# == Class: vserver::mediawiki
#
# Class for mediawiki instances.
#
# === Parameters:
# [*http_serveradmin*]
#   ServerAdmin config for apache
#
# These all get passed as global parameters since i am still using the ldap enc
#
class vserver::mediawiki {
  # @todo decide what to do with this, the deps already went to the mediawiki::gentoo module
  class { 'apache':
    serveradmin => $::http_serveradmin,
    require     => [File['/etc/portage/package.use/10_apache_nossl'], File['/etc/portage/package.use/10_apache_ldap']]
  }

  include ::mediawiki
}
