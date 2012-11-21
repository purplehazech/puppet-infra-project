# == Class: gem::params
#
class gem::params {
 case $::operatingsystem {
    windows: {
      $gem_install = false
    }
    default: {
      $gem_install      = true
      $gem_package_name = 'rubygems'
    }
 }
}
