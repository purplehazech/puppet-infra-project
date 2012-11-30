# == Define: zabbix::server::template
#
# install a template on the server
#
# === Parameters
# [*ensure*]
#   present or absent, default is present
#
define zabbix::server::template ($ensure = 'present', $template = "${name}/zabbix-template.json.erb") {
  zabbix_template { $name:
    content  => template($template),
    server   => $zabbix::params::zabbix_frontend_url,
    user     => 'Admin',
    password => 'zabbix'
  }
}
