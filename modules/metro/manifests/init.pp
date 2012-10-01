# Class: metro
#
# Class for deploying metro to a node from git (as recommended in metros dox)
# 

class metro {
    require ::ccache

    git::wc {
        "/var/lib/metro/":
            repo   => "https://github.com/purplehazech/metro.git",
            ensure => latest
    }

    file {
	"/home/mirror/":
		ensure => directory;
	"/home/mirror/linux/":
		ensure => directory;
	"/home/mirror/linux/rabe-dev/i686/i686":
		ensure => directory;
    }

}
