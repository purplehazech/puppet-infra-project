
class vserver {

    require ::puppet

    file {
        '/etc/make.profile':
            ensure => '/var/lib/layman/rabe-portage-overlay/profiles/default/linux/amd64/2012.0/rabe.ch/vserver'
    }
}
