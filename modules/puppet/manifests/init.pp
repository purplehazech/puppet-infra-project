
class puppet {
  case $::operatingsystem {
    windows : {
      $pluginsync = 'false'

      service { "puppet":
        ensure  => running,
        require => [File['C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf']]
      }

      file { 'C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf': content => template('puppet/puppet.conf.win.erb'
        ) }
    }
    default : {
      package {
        'puppet':
          ensure => installed,
          before => Service['puppet'];

        'hiera':
          ensure   => installed,
          provider => 'gem';

        'hiera-puppet':
          ensure   => installed,
          provider => 'gem'
      }

      # create links for including hiera
      file {
        '/usr/share/puppet':
          ensure => directory;

        '/usr/share/puppet/modules':
          ensure => directory;

        '/usr/share/puppet/modules/hiera':
          ensure  => link,
          target  => '/usr/local/lib64/ruby/gems/1.8/gems/hiera-puppet-1.0.0/',
          require => Package['hiera-puppet'];
      }

      if tagged(Class[puppet::master]) {
        # deactivated due to much bugieness on the windows side of things
        $pluginsync = 'false'
      } else {
        $pluginsync = 'false'
      }

      file { "/etc/puppet/puppet.conf": content => template("puppet/puppet.conf.erb") }

      service { "puppet":
        ensure  => running,
        require => [File["/etc/puppet/puppet.conf"]]
      }

      file { "/etc/cron.daily/eix-update": ensure => absent; }
    }
  }
}
