# == Define: zabbix::server::template
#
# install a template on the server
#
# === Parameters
# [*ensure*]
#   present or absent, default is present
#
define zabbix::server::template ($ensure = 'present') {
  zabbix_template { $name:
    server   => $zabbix::params::zabbix_frontend_url,
    user     => $zabbix::params::zabbix_frontend_user,
    password => $zabbix::params::zabbix_frontend_password
  }
}
