
class vserver::web {

    # @todo move stuff into apache module when stable

    class {
        'apache':
            serveradmin => 'purpleteam@purplehaze.ch';
        'apache::mod::proxy': 
            proxy_requests => 'On';
        'apache::vhost::proxy':
            port       => 80,
            dest       => 'http://intranet.rabe.ch',
            servername => 'newintranet.rabe.ch';
        'apache::vhost::proxy':
            port       => 443,
            ssl        => true,
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
