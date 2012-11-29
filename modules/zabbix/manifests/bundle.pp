# == Class: zabbix::bundle
#
# installs a zabbixized puppet module on both zabbix server and client
#
# Must only be included on the client.
#
# === Parameters
# [*ensure*]
#   present or absent, present is default
# [*server_template*]
#   defaults to "${name}/zabbix-template.xml.erb"
# [*agent_params*]
#   hash of user parameters to configure
#
# === Example Usage
#
class zabbix::bundle (
  $ensure          = 'present',
  $server_template = "${name}/zabbix-template.xml.erb",
  $agent_params    = {
  }
) inherits zabbix::params {
  $ensure_real = $ensure

  @@zabbix::server::template { $name:
    ensure   => $ensure_real,
    template => $server_template
  }

  zabbix::agent::params { $name:
    ensure => $ensure_real,
    params => $agent_params
  }

}
