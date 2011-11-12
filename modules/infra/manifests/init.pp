import "*.pp"

class infra {

    file {
        # do this in jenkins after bootstrap!
        "/var/git/puppet/hooks/post-receive":
            ensure  => empty,
    }

}
