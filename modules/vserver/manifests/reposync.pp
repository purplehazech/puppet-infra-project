
class vserver::reposync {

    require ::layman

    class { 'sudo':; }

    sudo::conf {
        'jenkins-alias':
            content => "Cmnd_Alias JENKINS = /usr/bin/layman --sync-all, /usr/bin/layman --sync=*, /usr/bin/eix-update\n";
        'jenkins-user':
            content => 'jenkins ALL = NOPASSWD: JENKINS';
    }

    service {
        "sshd":
            ensure => running;
    }

    user { "jenkins":
        ensure => present,
        shell => "/bin/sh",
        home => "/var/lib/jenkins"
    }

    file {
        "/var/lib/jenkins":
            ensure => directory,
            owner => 'jenkins';
        "/var/lib/jenkins/.ssh":
            ensure => directory,
            owner => 'jenkins',
            require => File['/var/lib/jenkins'];
        "/var/lib/jenkins/.ssh/authorized_keys":
            content => $jenkins_authorized_key,
            owner => jenkins,
            require => File['/var/lib/jenkins/.ssh/']
    }
}
