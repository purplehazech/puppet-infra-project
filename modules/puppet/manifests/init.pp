
class puppet {

    case $::operatingsystem {
        windows: {
            $pluginsync = 'true'

            service { "puppet":
                ensure => running,
                require => [
                    File['%ALLUSERSPROFILE%\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf']
                ]
            }
 
            file { '%ALLUSERSPROFILE%\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf':
                content => template('puppet/puppet.conf.erb'),
                subscribe => Service['puppet']
            }
        }
        default: {
            package {
                "puppet":
                    ensure => installed,
                    before => Service['puppet'];
        
            }
        
            if tagged(Class[puppet::master]) {
                $pluginsync = 'true'
            } else {
                $pluginsync = 'false'
            }
        
            file { "/etc/puppet/puppet.conf":
                content => template("puppet/puppet.conf.erb")
            }
        
            service { "puppet":
                ensure => running,
                require => [
                    File["/etc/puppet/puppet.conf"]
                ]
            }
        
            file {
                "/etc/cron.daily/eix-update":
                    content => '',
                    mode    => '0755'
            }
        }
    }
}
