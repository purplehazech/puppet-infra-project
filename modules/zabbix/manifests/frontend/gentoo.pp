class zabbix::frontend::gentoo {
  file {
    '/etc/portage/package.use/10_zabbix_frontend':
      content => 'net-analyzer/zabbix  ldap mysql server jabber snmp';

    '/etc/portage/package.use/10_php-zabbix_frontend':
      content => 'dev-lang/php truetype gd bcmath sockets';

    '/etc/portage/package.use/10_gd-zabbix_frontend':
      content => 'media-libs/gd png'

  }

}
