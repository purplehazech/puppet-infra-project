
class jenkins::htmlpublisher {
    jenkins::plugin {
        "htmlpublisher":
            ensure => present
    }
}
