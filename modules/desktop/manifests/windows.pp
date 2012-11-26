# == Class: desktop::windows
#
# === Parameters:
# [*::winCommonMusic*]
#   this one is actually from ldap :)
#
class desktop::windows {
  if $::winCommonMusic != '' {
    # off due to no pluginsync on windows agent in our version
    # @todo enter windows hell and fix
    # registry_value {
    #    'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\CommonMusic':
    #        ensure => present,
    #        type => string,
    #        data => $winCommonMusic
    #}
  }

}
