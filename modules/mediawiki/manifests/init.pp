# == Class: mediawiki
#
# === Parameters:
# [*mediawiki_sitename*]
#   wgSitename
# [*mediawiki_logo*]
#   wgLogo
# [*mediawiki_server*]
#   wgServer
# [*mediawiki_db_server*]
#  wgDBserver
# [*mediawiki_db_name*]
#  wgDBname
# [*mediawiki_db_user*]
#  wgDBuser
# [*mediawiki_db_password*]
#  wgDBpassword
# [*mediawiki_remote_auth*]
#  use and activate remote auth login
# [*mediawiki_ldap_auth*]
#  use and activate ldap auth
# [*mediawiki_ldap_autoauth*]
#  to auto auth or not to auto auth
# [*mediawiki_ldap_domain_name*]
#  wgLDAPDomainNames[0]
# [*mediawiki_ldap_server_name*]
#  wgLDAPServerNames[0]
# [*mediawiki_ldap_search_string*]
#  wgLDAPSearchStrings[0]
# [*mediawiki_ldap_proxy_agent*]
#  wgLDAPProxyAgent
# [*mediawiki_ldap_proxy_agent_password*]
#  wgLDAPProxyAgentPassword
#
class mediawiki {
  $mediawiki_raw_html                  = true
  $mediawiki_allow_copy_uploads        = true
  $mediawiki_disable_unauthed_edits    = true
  $mediawiki_file_extensions           = ['svg', 'pdf', 'ppt', 'xls', 'dia']
  $mediawiki_ldap_encryption_type      = 'clear'
  $mediawiki_enable_scary_transcluding = true
  $mediawiki_show_exception_details    = true
  $mediawiki_wikieditor                = true
  $mediawiki_socialprofile             = true
  $mediawiki_disable_anon              = true
  $mediawiki_enable_uploads            = true

  file {
    '/etc/portage/package.use/10_php_xmlreader':
      content => 'dev-lang/php xmlreader';

    '/etc/portage/package.use/10_mediawiki_mysql':
      content => 'www-apps/mediawiki mysql';

    '/etc/portage/package.use/10_mediawiki_vhosts':
      content => 'www-apps/mediawiki vhosts';

    '/etc/portage/package.use/10_mediawiki_imagemagick':
      content => 'www-apps/mediawiki imagemagick';

    '/etc/portage/package.use/10_imagemagick_mediawiki':
      content => 'media-gfx/imagemagick jpeg png svg';

    "/var/www/${fqdn}/htdocs/LocalSettings.php":
      content => template('mediawiki/LocalSettings.php.erb'),
      require => Webapp_config['mediawiki'];
  }

  package { 'mediawiki':
    ensure  => '1.19.2',
    require => [
      File['/etc/portage/package.use/10_mediawiki_mysql'],
      File['/etc/portage/package.use/10_mediawiki_vhosts'],
      File['/etc/portage/package.use/10_mediawiki_imagemagick'],
      File['/etc/portage/package.use/10_php_xmlreader']]
  }

  webapp_config { 'mediawiki':
    action  => 'install',
    vhost   => $fqdn,
    app     => 'mediawiki',
    version => '1.19.2',
    depends => Package['mediawiki']
  }

  if $mediawiki_remote_auth == true {
    package { 'mediawiki-ext-automatic-remoteuser':
      ensure => installed,
      before => Webapp_config['mediawiki']
    }
  }

  if $mediawiki_ldap_auth == true {
    package { 'mediawiki-ext-ldap-auth':
      ensure => installed,
      before => Webapp_config['mediawiki']
    }
  }

  if $mediawiki_socialprofile == true {
    package { 'mediawiki-ext-socialprofile':
      ensure => installed,
      before => Webapp_config['mediawiki']
    }
  }
}

