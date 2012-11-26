# == Class: git
#
# Contains tools and whatnot for interacting with git repos
#
# For now i am not adding puppet-module-git like server
# capabilities.
#
class git {
  package { 'git': ensure => installed }
}