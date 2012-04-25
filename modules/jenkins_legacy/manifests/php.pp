class jenkins::php {
    package {
        "phpunit":
            ensure => installed
    }
}
