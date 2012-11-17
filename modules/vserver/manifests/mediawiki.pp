# == Class: vserver::mediawiki
#
# Class for mediawiki instances.
#
# === Parameters
# [*http_serveradmin*]
#   ServerAdmin config for apache
#
# These all get passed as global parameters since i am still using the ldap enc
#
class vserver::mediawiki {
  class { 'apache':
    serveradmin => $http_serveradmin,
    require     => [File['/etc/portage/package.use/10_apache_nossl'], File['/etc/portage/package.use/10_apache_ldap']]
  }

  apache::vhost { 'default_vhost':
    port       => 80,
    docroot    => "/var/www/${fqdn}/htdocs",
    servername => $fqdn,
    require    => Class['apache'];
  }

  file {
    "/var/www/${fqdn}":
      ensure  => directory,
      require => Class['apache'];

    '/etc/portage/package.use/10_apache_nossl':
      content => 'www-servers/apache -ssl';

    '/etc/portage/package.use/10_apache_ldap':
      content => 'www-servers/apache ldap';

    '/etc/portage/package.use/10_php_default':
      content => 'dev-lang/php unicode curl';

    '/etc/portage/package.use/10_php_apache':
      content => 'dev-lang/php apache2';

    '/etc/portage/package.use/10_php_mysql':
      content => 'dev-lang/php mysql mysqli -berkdb';

    '/etc/portage/package.use/10_php_ldap':
      content => 'dev-lang/php ldap ldap-sasl';

    '/etc/portage/package.use/10_php_memcached':
      content => 'dev-lang/php memcached';

    '/etc/portage/package.use/10_apache_ldap_apr':
      content => 'dev-libs/apr-util ldap';

    '/etc/portage/package.use/10_apache_ldap_minimal':
      content => 'net-nds/openldap minimal';
  }

  file_line { 'enable-php-/etc/conf.d/apache2':
    path    => '/etc/conf.d/apache2',
    line    => 'APACHE2_OPTS="-D INFO -D SSL -D LANGUAGE -D LDAP -D PHP5"',
    require => Class['apache']
  }

  file_line { 'apache2-modules-/etc/make.conf':
    path   => '/etc/make.conf',
    line   => 'APACHE2_MODULES="actions alias auth_basic authn_alias authn_default authn_file authz_default authz_groupfile authz_host authz_owner authz_user autoindex cgi dir env imagemap include info log_config logio mime mime_magic negotiation rewrite setenvif status unique_id userdir usertrack"',
    before => Class['apache']
  }
}
