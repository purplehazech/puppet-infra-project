
class vserver::busmaster {

    # pulling in a not so minimal php config 
    file { "/etc/portage/package.use/rabe-bustmaster":
        content => template("vserver/busmaster.use.erb")
    }

    package { "rabe-busmaster":; }


    service { "gearmand":
        ensure => running
    }
}
