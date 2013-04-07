# == Class: vserver::web
#
# Class for our main proxy vhost
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
