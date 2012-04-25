
node "jenkins-01.hq.rabe.ch" {

    include infra::gentoo

    include gentoo::rabe # our own overlay
    include gentoo::godin # thats where jenkins is from

    include ant
    include sudo

    class jenkins {
      jenkins::plugin {
        analysis-core: ;
        analysis-collector: ;
        github: ;
        puppet: ;
        mantis: ;
        php: ;
	artifactdeployer: ;
      }
    }
}
