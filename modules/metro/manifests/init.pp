# Class: metro
#
# Class for deploying metro to a node from git (as recommended in metros dox)
# 

class metro {
    require ccache;
    git::wc {
        "/var/lib/metro/":
            repo   => "https://github.com/funtoo/metro.git",
            ensure => latest
    }
}
