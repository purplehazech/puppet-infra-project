
class jenkins::mantis {
    jenkins::plugin {
        "mantis":
            ensure => present
    }
}
