# == Class: zabbix::server
#
# set up a zabbix server
#
# @todo implement zabbix::server
class zabbix::server inherits zabbix::params {
  include zabbix::server::gentoo
  # install templates needed by different nodes
  Zabbix::Server::Template <<| |>>
}
