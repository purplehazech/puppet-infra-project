
class puppet {

    case $::operatingsystem {
        windows: {
            $pluginsync = 'false'

            service { "puppet":
                ensure => running,
                require => [
                    File['C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf']
                ]
            }
 
            file { 'C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf':
                content => template('puppet/puppet.conf.win.erb')
            }
        }
        default: {
            package {
                "puppet":
                    ensure => installed,
                    before => Service['puppet'];
        
            }
        
            if tagged(Class[puppet::master]) {
                # deactivated due to much bugieness on the windows side of things
                $pluginsync = 'false'
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
