# == Class: layman::params
#
# setup default layman params
#
# see layman and layman::repository for usage details
#
class layman::params {
  $laymap_cfg_file     = '/etc/layman/layman.cfg'
  $layman_cfg_overlays = [
    'http://godin-gentoo-repository.googlecode.com/svn/trunk/layman.xml',
    'http://intranet.rabe.ch/portage-overlay/repositories.xml']
}
