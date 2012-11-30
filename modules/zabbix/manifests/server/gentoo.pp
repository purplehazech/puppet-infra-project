# == Class: zabbix::server::gentoo
#
class zabbix::server::gentoo {
  file {
    '/etc/portage/package.use/10_zabbix_server':
      content => 'net-analyzer/zabbix  ldap mysql server jabber snmp';

    '/etc/portage/package.use/10_php-zabbix_server':
      content => 'dev-lang/php truetype gd bcmath sockets';
  }

}