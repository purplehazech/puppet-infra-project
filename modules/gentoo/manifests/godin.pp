# == Class: gentoo::godin
#
# class for adding the godwin overlay
#
class gentoo::godin {
  package { # needed for syncing godwin overlay
            # @todo will move this incantation to a nicer location when i configure svn
  'subversion': ensure => installed, }

  exec { 'add godin repo to layman':
    command => '/usr/bin/layman -a godin',
    creates => '/var/lib/layman/godin/',
    require => Exec['sync layman repos']
  }
}
