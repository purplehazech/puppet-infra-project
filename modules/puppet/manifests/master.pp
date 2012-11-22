class puppet::master inherits puppet::params {

  case $puppet_master_infra_version {
    latest: {
      package { 'puppet-infra-project':
        ensure => latest
      }
      $puppet_master_infra_resource = Package['puppet-infra-project']
    }
    'git': {
      # @todo implement autosyncing
      $puppet_master_infra_resource = []
    }
  }

  service { 'puppetmaster':
    ensure  => running,
    require => [File[$puppet_conf_file], $puppet_master_infra_resource]
  }

  package { 'puppet-dashboard':
    ensure => installed
  }

  service { $puppet_dashboard_services:
    ensure => running
  }

  # @todo create puppet::dashboard and let it confiure dashboard
  # dashboard needs to stabilize, i hacked package.keywords by hand for now
  # use flags are here though
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

# EO
