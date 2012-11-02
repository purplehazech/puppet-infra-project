
class vserver::reposync ($jenkins_authorized_key) {
  class { 'layman': sync => true }

  exec {
    'add rabe rep1o to layman':
      command => '/usr/bin/layman -a rabe-portage-overlay',
      creates => '/var/lib/layman/rabe-portage-overlay/',
      require => Exec['sync layman repos'];

    'add gentoo-vnkuznet-overlay repo to layman':
      command => '/usr/bin/layman -a  gentoo-vnkuznet-overlay',
      creates => '/var/lib/layman/gentoo-vnkuznet-overlay/',
      require => Exec['sync layman repos'];
    /*
     *    "add rabe repo to layman":
     *            command => "/usr/bin/layman -a rabe-portage-overlay",
     *            creates => "/var/lib/layman/rabe-portage-overlay/",
     *            require => Exec["sync layman repos"];
     */
  }

  eix { 'eix': ; }

  class { 'sudo': ; }

  sudo::conf {
    'jenkins-alias':
      content => "Cmnd_Alias JENKINS = /usr/bin/layman --sync-all, /usr/bin/layman --sync=*, /usr/bin/eix-update\n";

    'jenkins-user':
      content => 'jenkins ALL = NOPASSWD: JENKINS';
  }

  service { 'sshd': ensure => running; }

  user { 'jenkins':
    ensure => present,
    shell  => '/bin/sh',
    home   => '/var/lib/jenkins'
  }

  file {
    '/var/lib/jenkins':
      ensure => directory,
      owner  => 'jenkins';

    '/var/lib/jenkins/.ssh':
      ensure  => directory,
      owner   => 'jenkins',
      require => File['/var/lib/jenkins'];

    '/var/lib/jenkins/.ssh/authorized_keys':
      content => $jenkins_authorized_key,
      owner   => jenkins,
      require => File['/var/lib/jenkins/.ssh/']
  }
}
#
