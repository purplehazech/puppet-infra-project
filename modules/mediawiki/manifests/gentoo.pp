# == Class: mediawiki::gentoo
#
# a class that sets up most use flag needed for this install
#
# you still get to do the keywording my hand :)
#
class mediawiki::gentoo {
  include layman::overlay::rabe_portage_overlay

  file {
    '/etc/portage/package.use/10_php_xmlreader':
      content => 'dev-lang/php xmlreader';

    '/etc/portage/package.use/10_mediawiki_mysql':
      content => 'www-apps/mediawiki mysql';

    '/etc/portage/package.use/10_mediawiki_vhosts':
      content => 'www-apps/mediawiki vhosts';

    '/etc/portage/package.use/10_mediawiki_imagemagick':
      content => 'www-apps/mediawiki imagemagick';

    '/etc/portage/package.use/10_imagemagick_mediawiki':
      content => 'media-gfx/imagemagick jpeg png svg';

    '/etc/portage/package.use/10_apache_nossl':
      content => 'www-servers/apache -ssl';

    '/etc/portage/package.use/10_apache_ldap':
      content => 'www-servers/apache ldap';

    '/etc/portage/package.use/10_php_default':
      content => 'dev-lang/php unicode curl curlwrappers';

    '/etc/portage/package.use/10_php_apache':
      content => 'dev-lang/php apache2';

    '/etc/portage/package.use/10_mysql_virtual_minimal':
      content => 'virtual/mysql minimal';

    '/etc/portage/package.use/10_mysql_minimal':
      content => 'dev-db/mysql minimal';

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
  } -> Package['mediawiki']

  # @todo move these two into apache module
  file_line { 'enable-php-/etc/conf.d/apache2':
    ensure  => present,
    path    => '/etc/conf.d/apache2',
    line    => 'APACHE2_OPTS="-D INFO -D SSL -D LANGUAGE -D LDAP -D PHP5"',
    match   => '/^APACHE2_OPTS=/',
    require => Class['apache']
  }

  file_line { 'apache2-modules-/etc/make.conf':
    ensure => present,
    path   => '/etc/make.conf',
    line   => 'APACHE2_MODULES="actions alias auth_basic authn_alias authn_default authn_file authz_default authz_groupfile authz_host authz_owner authz_user autoindex cgi dir env imagemap include info log_config logio mime mime_magic negotiation rewrite setenvif status unique_id userdir usertrack"',
    match  => '/^APACHE2_MODULES=/',
    before => Class['apache']
  }

}

