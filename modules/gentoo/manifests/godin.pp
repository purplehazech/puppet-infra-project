# == Class: gentoo::godin
#
# class for adding the godwin overlay
#
class gentoo::godin {
  package { # needed for syncing godwin overlay
            # @todo will move this incantation to a nicer location when i configure svn
  'subversion': ensure => installed, }

  layman::overlay { 'godin': }
}
