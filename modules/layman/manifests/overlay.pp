# == Define: layman::overlay
#
# add and sync an overlay to layman
#
define layman::overlay ($require = [], $schedule = 'daily') {
  include layman

  $layman_dir = getvar('layman::layman_dir')

  exec { "layman::overlay-add-repo-${name}":
    command => "/usr/bin/layman -a ${name}",
    creates => "${layman_dir}/${name}",
    require => $require
  } -> exec { "layman::overlay-sync-repo-${name}":
    command  => "/usr/bin/layman -s ${name}",
    schedule => $schedule
  }

}
