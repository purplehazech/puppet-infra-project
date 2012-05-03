class eix {

    package { "eix":
        ensure => installed
    }

    file {
        "/var/cache/eix":
            ensure => directory;
        "/etc/eixrc":
            content => template("eix/eixrc.erb")
    }
}
