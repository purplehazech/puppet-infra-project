
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
            servername => 'intranet.rabe.ch';
        'default_ssl_vhost':
            port       => 443,
            ssl        => true,
            ssl_cert   => 'intranet.rabe.ch.crt.pem',
            ssl_key    => 'intranet.rabe.ch.key.pem',
            ssl_ca     => 'intermediate.rapidssl.com.ca.pem',
            dest       => 'http://intranet.rabe.ch',
            servername => 'intranet.rabe.ch';
    }

    apache::vhost::include::proxy {
        'mantis_default_reverseproxy':
            proxy_vhost => 'default_vhost',
            location    => '/mantisbt/',
            dest        => 'http://10.1.1.93:80/';
        'mantis_default_ssl_reverseproxy':
            proxy_vhost => 'default_ssl_vhost',
            location    => '/mantisbt/',
            dest        => 'http://10.1.1.93:80/';
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
