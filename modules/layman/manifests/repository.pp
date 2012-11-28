# == Class: layman::repository
#
# add a reposity url to layman.cfg
#
# === Parameters
# [*ensure*]
#   should this repolist get added to layman
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
#    ensure => true,
#    url    => 'http://example.com/repositories.xml'
#  }
#
class layman::repository ($ensure = true, $url = undef) inherits layman::params {
  if $url != undef {
    $url_real = $url
  } else {
    $url_real = $name
  }
  $line_real = "            ${url_real}"

  file_line { "layman::repository-layman.cfg-${name}":
    ensure  => $ensure,
    line    => $line_real,
    require => File[$laymap_cfg_file]
  }

}