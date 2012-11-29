# == Class: zabbix::bundle
#
# installs a zabbixized puppet module on both zabbix server and client
#
# === Parameters
# [*ensure*]
#   present or absent, present is default
# [*server_template*]
#   defaults to "${name}/zabbix-template.xml.erb"
#
class zabbix::bundle ($ensure = 'present', $server_template = undef) inherits zabbix::params {
  if $server_template == undef {
    $server_template = "${name}/zabbix-template.xml.erb"
  }
}
