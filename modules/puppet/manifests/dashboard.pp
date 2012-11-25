# == Class: puppet::dashboard
#
class puppet::dashboard inherits puppet::params {
  package { 'puppet-dashboard': ensure => installed }

  file { $puppet_dashboard_database_yaml_file: content => template('puppet/dashboard_database.yaml.erb') }

  service { $puppet_dashboard_services:
    ensure  => running,
    require => Package['puppet-dashboard']
  }

  # @todo create puppet::dashboard and let it confiure dashboard
  # dashboard needs to stabilize, i hacked package.keywords by hand for now
  # use flags are here though, all in all a rather nasty hack that id rather
  # not repeat, in seriously just considering to deploy the dashboard instead
  # of installing it, not my fav solution :(
  #
  # file {
  #    "/etc/portage/package.use/puppet-dashboard":
  #       content => "app-admin/puppet-dashboard mysql imagemagick fastcgi\ndev-ruby/activerecord mysql\ndev-lang/ruby threads";
  #   "/etc/portage/package.keywords/puppet-dashboard": ;
  #}
  # also i hacked the init script to also start delayed_jobs
  # then there where the whole changes to puppet-dashboards
  # config that live in /var/lib/puppet-dashboard/config
  # and should also get ported in here.
  # basically i'll try and revist this part of the puppet
  # scripts when the dashboard is a bit more mature.
  # i might even decide to just pop the report data into
  # zabbix without using the dashboard...
}
