class gentoo {

    filebucket { 'gentoo':
        server => "$puppet_server",
        path => false; 
    }

    file { '/var/lib/portage/world':
        backup => 'gentoo';
    }
}
