# == Class gentoo
#
# some basic setup for keeping gentoo in check.
#
class gentoo (
  $puppet_server = 'puppet'
) {
  
  # gentoo file bucket for gentoo related files
  filebucket { 'gentoo':
    server => $puppet_server,
    path   => false;
  }

  # store world file 
  file { '/var/lib/portage/world':
    backup => 'gentoo'
  }
  
  # used by various puppet modules
  file { '/var/lib/infra':
    ensure => directory,
    mode   => '0755'
  }
}