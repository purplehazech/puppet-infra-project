
class infra::gentoo {

    include infra

    file {
        "/var/lib/infra/":
            ensure => directory;
    }

}
