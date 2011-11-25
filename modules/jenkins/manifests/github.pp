
class jenkins::github {
    jenkins::plugin {
        "github":
            ensure => present
    }
}
