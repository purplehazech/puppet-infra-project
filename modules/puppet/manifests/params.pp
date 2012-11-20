# == Class: puppet::params
#
class puppet::params {
  case $::operatingsystem {
    windows: {
      $puppet_install       = false
      $puppet_pluginsync    = false
      $puppet_conf_file     = 'C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf'
      $puppet_conf_template = 'puppet.conf.win.erb'
    }
    Gentoo: {
      $puppet_install = true
      $puppet_hiera_gem = false
      # @bug: windows makes problems when master has sync but clients dont
      $puppet_pluginsync = false
      $puppet_conf_file = '/etc/puppet/puppet.conf'
      $puppet_conf_template = 'puppet.conf.erb'
      $puppet_master_infra_version = latest
      # @todo unbreak me in rabe infra
      $puppet_install_dashboard = false
      $puppet_dashboard_services = ['puppet-dashboard']
    }
    default: {
      $puppet_install = true
      $puppet_hiera_gem = false
      $puppet_pluginsync = true
      $puppet_conf_file = '/etc/puppet/puppet.conf'
      $puppet_conf_template = 'puppet.conf.erb'
      $puppet_master_infra_version = 'git'
      $puppet_install_dashboard = true
      $puppet_dashboard_services = ['puppet-dashboard', 'puppet-dashboard-workers']
    }
  }
}
