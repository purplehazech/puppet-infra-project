
node "jenkins-01.hq.rabe.ch" {
    include infra::gentoo
    include gentoo::rabe # our own overlay
    include gentoo::godin # thats where jenkins is from
    include jenkins
    include ant
    include jenkins::github
    include sudo
    include jenkins::puppet
    include jenkins::mantis
    include jenkins::php
}
