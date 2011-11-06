
user {
	"git":
		ensure => present,
		home   => "/var/git"
}

file {
	"/var/git":
		ensure  => directory,
		owner   => git,
		require => User['git']
	;
	"/var/git/puppet/":
		ensure  => directory,
		owner   => git,
		require => File['/var/git']
}

package {
	"git":
		ensure => installed
}

exec {
	"bare puppet git repo":
		cwd     => "/var/git/puppet",
		user    => git,
		command => "/usr/bin/git init --bare",
		creates => "/var/git/puppet/HEAD",
		require => [
			Package['git'],
			File['/var/git/puppet']
		]
	;
	"remote puppet git repo":
		cwd     => "/var/git/puppet",
		user    => git,
		command => "/usr/bin/git remote add origin git://github.com/purplehazech/puppet-infra-project",
		onlyif  => "/bin/grep -v origin /var/git/puppet/config && exit 1",
		require => Exec["bare puppet git repo"]
}
file {
	"/var/git/puppet/hooks/post-receive":
		ensure  => file,
		owner   => git,
		mode    => 555,
		content => "/usr/bin/git archive --format=tar HEAR /var/git/puppet | (cd /etc/puppet/ && tar xf - )",
		require => Exec["bare puppet git repo"]
}


