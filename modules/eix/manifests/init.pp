define eix (
    $ensure = installed
) {

    package { "eix":
        ensure => $ensure
    }

    file {
        "/var/cache/eix":
            ensure => directory;
        "/etc/eixrc":
            content => template("eix/eixrc.erb")
    }
}
