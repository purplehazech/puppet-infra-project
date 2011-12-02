
# development node for running jenking on gentoo
node gentoo-jenkins-dev {
	# gentoo base install
	include infra::gentoo
	# godin overlay for jenkins
	include gentoo::godin
	# finally grab jenkins
	include jenkins
    include ant
	include jenkins::github
    include sudo
    include jenkins::puppet
    include jenkins::mantis
}

# development node for installing a ubuntu audio player for 7/24 playback
node ubuntu-player-dev {
    include infra::ubuntu
}
