
class sudo::jenkins {

    file {
        "/etc/sudoers.d/jenkins_puppet":
            ensure  => file,
            owner   => root,
            mode    => 440,
            content => template("sudo/jenkins_puppet_sudoers.erb")
    }
}

