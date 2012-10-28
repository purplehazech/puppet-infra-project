
class vserver::web {

    # @todo move stuff into apache module when stable
    class {
        'apache':
            serveradmin => 'purpleteam@purplehaze.ch'
    }
    apache::vhost::proxy {
        'default_vhost':
            port       => 80,
            dest       => 'http://intranet.rabe.ch',
            servername => 'newintranet.rabe.ch';
        'default_ssl_vhost':
            port       => 443,
            ssl        => true,
            ssl_cert   => 'server.crt',
            ssl_key    => 'server.key',
            dest       => 'http://intranet.rabe.ch',
            servername => 'newintranet.rabe.ch';
    }

    file {
        "/etc/portage/package.use/10_apache_proxy":
            content => "www-servers/apache proxy proxy_balancer";
        "/etc/portage/package.use/10_apache_ldap":
            content => "www-servers/apache ldap";
        "/etc/portage/package.use/10_apache_ldap_apr":
            content => "dev-libs/apr-util ldap";
        "/etc/portage/package.use/10_apache_ldap_minimal":
            content => "net-nds/openldap minimal";
        "/etc/conf.d/apache2":
            content => 'APACHE2_OPTS="-D INFO -D SSL -D LANGUAGE -D LDAP -D PROXY -D PROXY_HTML -D AUTHNZ_EXTERNAL"'
    }

}
