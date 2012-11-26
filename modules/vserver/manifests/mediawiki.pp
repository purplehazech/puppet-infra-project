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
  class { 'apache':
    serveradmin => $::http_serveradmin,
    require     => [File['/etc/portage/package.use/10_apache_nossl'], File['/etc/portage/package.use/10_apache_ldap']]
  }

  apache::vhost { 'default_vhost':
    port       => 80,
    docroot    => "/var/www/${fqdn}/htdocs",
    servername => $fqdn;
  }

  # @todo these belong in apache::vhost somewhere
  file {
    "/var/www/${fqdn}":
      ensure => directory,
      mode   => '0755';

    "/var/www/${fqdn}/htdocs":
      ensure => directory,
      mode   => '0755';
  }

  include ::mediawiki
}

