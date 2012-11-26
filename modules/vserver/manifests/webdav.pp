# == Class: vserver::webdav
#
# setup a webdavcgi based webdav server
#
# === Parameters:
# [*::webdav_hostname*]
#   a hostname
# [*::webdav_docroot*]
#    a docroot? aw code smell :)
#
class vserver::webdav {
  webdavcgi { 'webdav':
    hostname => $::webdav_hostname,
    docroot  => $::webdav_docroot,
    ldap     => true;
  }
}
