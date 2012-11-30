# == Define: zabbix::server::template
#
# install a template on the server
#
# === Parameters
# [*ensure*]
#   present or absent, default is present
#
define zabbix::server::template ($ensure = 'present', $template = "${name}/zabbix-template.xml.erb") {
  zabbix_template { $name:
  }
}
