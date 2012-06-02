
class vserver::web {

    # @todo move stuff into apache module when stable

    package {
        "apache":
            ensure => installed
    }

    service {
        "apache2":
            ensure => running,
            subscribe => [
                Package['apache']
            ]
    }

}
