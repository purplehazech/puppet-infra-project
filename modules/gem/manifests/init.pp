# == Class: gem
#
# A class to manage the ruby gem packager and ruby gems.
#
# @todo implement the above
#
class gem inherits gem::params {
  if ($gem_install) {
    package { $gem_package_name:
      ensure => installed,
    }
  }
}
