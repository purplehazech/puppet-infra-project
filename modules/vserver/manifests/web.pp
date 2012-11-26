# == Class: vserver::web
#
# Class for our main proxy vhost
#
# @todo move proxy_* config stuff to puppetdb
#
# === Parameters
# [*http_serveradmin*]
#   ServerAdmin config for apache
# [*proxy_fallback*]
#   What server to proxy requests through if no proxy::include matches
# [*proxy_mantisbt*]
#   Where /mantisbt/ shall proxy to
# [*proxy_webdav*]
#   Where /webdav/ shall proxy to
# [*proxy_jenkins*]
#   Where /jenkins/ shall proxy to
# [*proxy_mediawiki*]
#   Where /mediawiki/ goes
# [*proxy_mediaiki_test*]
#   Where /mediawiki-test/ goes
#
# These all get passed as global parameters since i am still using the ldap enc
#
class vserver::web {
  class { 'apache': serveradmin => $::http_serveradmin }

  apache::vhost::proxy {
    'default_vhost':
      port       => 80,
      dest       => $::proxy_fallback,
      servername => 'intranet.rabe.ch';

    'default_ssl_vhost':
      port       => 443,
      ssl        => true,
      ssl_cert   => 'intranet.rabe.ch.crt.pem',
      ssl_key    => 'intranet.rabe.ch.key.pem',
      ssl_ca     => 'intermediate.rapidssl.com.ca.pem',
      dest       => $::proxy_fallback,
      servername => 'intranet.rabe.ch';
  }

  if $::proxy_mantisbt != undef {
    apache::vhost::include::proxy { 'mantis_default_ssl_reverseproxy':
      proxy_vhost => 'default_ssl_vhost',
      location    => '/mantisbt/',
      dest        => $::proxy_mantisbt;
    }
  }

  if $::proxy_webdav != undef {
    apache::vhost::include::proxy { 'webdav_default_ssl_reverseproxy':
      proxy_vhost => 'default_ssl_vhost',
      location    => '/webdav/',
      url_map     => '/ /webdav/',
      dest        => $::proxy_webdav;
    }
  }

  if $::proxy_jenkins != undef {
    apache::vhost::include::proxy { 'jenkins_default_ssl_reverseproxy':
      proxy_vhost => 'default_ssl_vhost',
      location    => '/jenkins',
      url_map     => '/ /jenkins',
      dest        => $::proxy_jenkins;
    }
  }

  if $::proxy_mediawiki != undef {
    apache::vhost::include::proxy { 'mediawiki_default_ssl_reverseproxy':
      proxy_vhost => 'default_ssl_vhost',
      location    => '/mediawiki/',
      url_map     => '/ /mediawiki/',
      dest        => $::proxy_mediawiki;
    }
  }

  Apache::Vhost::Include::Proxy <<| tag == 'extranet' |>>

  file {
    '/etc/portage/package.use/10_apache_proxy':
      content => 'www-servers/apache proxy proxy_balancer';

    '/etc/portage/package.use/10_apache_ldap':
      content => 'www-servers/apache ldap';

    '/etc/portage/package.use/10_apache_ldap_apr':
      content => 'dev-libs/apr-util ldap';

    '/etc/portage/package.use/10_apache_ldap_minimal':
      content => 'net-nds/openldap minimal';

    # @todo mediawiki does this friendlier, abstract and win! (this probably need gentoo work in modules/apache, thou art warned)
    '/etc/conf.d/apache2':
      content => 'APACHE2_OPTS="-D INFO -D SSL -D LANGUAGE -D LDAP -D PROXY -D PROXY_HTML -D AUTHNZ_EXTERNAL"'
  }
}
