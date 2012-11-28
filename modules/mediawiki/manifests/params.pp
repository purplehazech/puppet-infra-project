# == Class: mediawiki::params
#
# heaps of config for mediawiki
#
class mediawiki::params {
  $mediawiki_version                   = '1.19.2'
  $mediawiki_raw_html                  = true
  $mediawiki_allow_copy_uploads        = true
  $mediawiki_disable_unauthed_edits    = true
  $mediawiki_enable_uploads            = true
  $mediawiki_enable_scary_transcluding = true
  $mediawiki_show_exception_details    = true

  $mediawiki_file_extensions           = ['svg', 'pdf', 'ppt', 'xls', 'dia']

  $mediawiki_ldap_encryption_type      = 'clear'

  $mediawiki_wikieditor                = true

  $mediawiki_socialprofile             = true
  $mediawiki_disable_anon              = true

  $mediawiki_email_authentication      = false
  $mediawiki_enotif_user_talk          = true
  $mediawiki_enotif_watchlist          = true
  $mediawiki_enable_email              = true
  $mediawiki_enable_user_email         = false

  $mediawiki_rights_url                = 'http://creativecommons.org/licenses/by-nc-sa/2.5/ch/'
  $mediawiki_rights_text               = 'Attribution-Noncommercial-Share Alike 2.5 Switzerland License'
  $mediawiki_rights_icon               = 'https://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png'

  $mediawiki_main_cache_type           = 'CACHE_MEMCACHED'
  $mediawiki_cached_server             = "${fqdn}:11211"

}
