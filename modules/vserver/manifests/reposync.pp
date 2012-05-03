
class vserver::reposync {

    require ::layman

    package { 
        "nfs-utils":
            ensure => installed;
    }

    class { 'sudo':; }

    sudo::conf {
        'jenkins-alias':
            content => 'Cmnd_Alias JENKINS = /usr/bin/layman --sync-all, /usr/bin/layman --sync=*, /usr/bin/eix-update';
        'jenkins-user':
            content => 'jenkins ALL = NOPASSWD: JENKINS';
    }

    service { "sshd":
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
            owner => 'jenkins'
            require => File['/var/lib/jenkins'];
        "/var/lib/jenkins/.ssh/authorized_keys":
            ensure => exists,
            owner => jenkins,
            require => File['/var/lib/jenkins/.ssh/']
    }

    file_line {
        "jenkins-publish-authorized_key":
            line => $jenkins_authorized_key
            path => '/var/lib/jenkins/authorized_keys'
            require => File['/var/lib/jenkins/authorized_keys']
            
    }
}
