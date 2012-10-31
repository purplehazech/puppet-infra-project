# Class: metro
#
# Class for deploying metro to a node from git (as recommended in metros dox)
# 

class metro {

    ccache { 'ccache': ; }

    git::wc {
        "/var/lib/metro/":
            ensure => latest,
            repo   => "https://github.com/purplehazech/metro.git",
    }

    file {
	"/home/mirror/":
		ensure => directory;
	"/home/mirror/linux/":
		ensure => directory;
	"/home/mirror/linux/rabe-dev/x86-32bit/i686":
		ensure => directory;
	"/var/lib/jenkins/workspace/rabe-metro-desktop":
		ensure => link,
		target => "/var/lib/metro";
    }

    class { 'sudo':; }

    sudo::conf {
        'jenkins-alias':
            content => "Cmnd_Alias JENKINS = /var/lib/metro/scripts/ezbuild.sh rabe-* *\n";
        'jenkins-user':
            content => 'jenkins ALL = NOPASSWD: JENKINS';
    }


}
