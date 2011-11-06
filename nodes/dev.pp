
node gentoo-jenkins-dev {
	# gentoo base install
	include infra::gentoo
	# godin overlay for jenkins
	include gentoo::godin
	# finally grab jenkins
	include jenkins
}
