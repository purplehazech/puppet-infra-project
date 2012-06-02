
class vserver::web {

    # @todo move stuff into apache module when stable

    package {
        "apache":
            ensure => installed
    }

    service {
        "apache":
            ensure => running,
            subscribe => [
                Package['apache']
            ]
    }

}
