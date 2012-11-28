# == Define: layman::overlay
#
# add and sync an overlay to layman
#
define layman::overlay ($require = []) {
  exec { "layman::overlay-add-repo-${name}":
    command => "/usr/bin/layman -a ${name}",
    creates => "/var/lib/layman/${name}/",
    require => $require
  } -> exec { "layman::overlay-sync-repo-${name}": command => "/usr/bin/layman -s ${name}" }
}

