
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

}
