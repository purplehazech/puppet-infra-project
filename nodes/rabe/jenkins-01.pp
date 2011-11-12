
node "jenkins-01.hq.rabe.ch" {
    include infra::gentoo
    include gentoo::godin # thats where jenkins is from
    include jenkins
    include ant
    include jenkins::github
    # sudo for applying updates!
    include sudo
}
