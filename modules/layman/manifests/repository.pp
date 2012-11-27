# == Define: layman::repository
#
# add a reposity url to layman.cfg
#
# === Parameters
# [*ensure*]
#   should this repolist get added to layman, present or absent
# [*url*]
#   replace name as the main url
#
# === Example Usage
#
#  layman::repository {'http://example.com/repositories.xml':}
#
# alternative syntax
#
#  layman::repository { 'example':
#    ensure => present,
#    url    => 'http://example.com/repositories.xml'
#  }
#
define layman::repository ($ensure = present, $url = undef) {
  if $url != undef {
    $url_real = $url
  } else {
    $url_real = $name
  }

  file_line { "layman::repository-layman.cfg-${name}":
    ensure  => $ensure,
    line    => "            ${url_real}",
    path    => getvar('layman::params::laymap_cfg_file'),
    require => File[getvar('layman::params::laymap_cfg_file')]
  }

}
