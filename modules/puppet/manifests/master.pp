class puppet::master {

    require puppet

    if ( $master == true ) {
    
        package { 
    	    "puppet-infra-project": 
    	        ensure => latest;
    	    "puppet-dashboard":
    	        # latest+noop to make sure i don't forget to cleanup when i upgrade
    	        ensure => latest,
    	        noop => true
        }
    
        # @todo dashboard needs to stabilize, i hacked package.keywords by hand for now
        # use flags are here though
        #file {
        #	"/etc/portage/package.use/puppet-dashboard":
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
    
        service { "puppetmaster":
            ensure => running,
            require => [
    	    Package["puppet-infra-project"]
            ]
        }
    }
}
