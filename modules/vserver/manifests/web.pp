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
