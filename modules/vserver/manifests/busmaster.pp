
class vserver::busmaster {

    file { 
        # pulling in a not so minimal php config 
        "/etc/portage/package.use/rabe-bustmaster":
            content => template("vserver/busmaster.use.erb");
	"/etc/busmaster":
	    ensure => directory;
	"/etc/busmaster/gearman.ini":
	    ensure => file;
    }

    package { "rabe-busmaster":; }


    service { 
        "gearmand":
            ensure => running;
        "memcached":
	    ensure => running;
    }
}
