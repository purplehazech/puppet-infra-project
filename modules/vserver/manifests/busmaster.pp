
class vserver::busmaster {

    file { 
        # pulling in a not so minimal php config 
        "/etc/portage/package.use/rabe-bustmaster":
            content => template("vserver/busmaster.use.erb");
        "/etc/busmaster":
            ensure => directory;
        "/etc/busmaster/gearman.ini":
            ensure => file;
        "/usr/share/rabe-busmaster/etc":
            ensure => "/etc/busmaster"
    }

    package {
        "rabe-busmaster":
            ensure => latest
    }


    service { 
        "gearmand":
            ensure => running;
        "memcached":
            ensure => running;
    }
}
