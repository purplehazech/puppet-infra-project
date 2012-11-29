# == Class: mediawiki
#
# install a mediawiki to the $fqdn vhost on the machine
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
class mediawiki inherits mediawiki::params {
  include mediawiki::gentoo
  include mediawiki::exports
  include mediawiki::vhost

  anchor { 'mediawiki::start':
    before => Package['mediawiki']
  }

  file { "/var/www/${fqdn}/htdocs/LocalSettings.php":
    ensure  => file,
    content => template('mediawiki/LocalSettings.php.erb')
  }

  package { 'mediawiki':
    ensure => $mediawiki_version,
    before => Anchor['mediawiki::end']
  } ~> webapp_config { 'mediawiki':
    action  => 'install',
    vhost   => $fqdn,
    app     => 'mediawiki',
    version => $mediawiki_version,
    depends => File["/var/www/${fqdn}/htdocs/LocalSettings.php"]
  }

  if $::mediawiki_remote_auth == true {
    Layman::Overlay['rabe-portage-overlay'] ~> Webapp_config['mediawiki'] ~> package { 'mediawiki-ext-automatic-remoteuser':
      ensure => installed,
      before => Anchor['mediawiki::end']
    }
  }

  if $::mediawiki_ldap_auth == true {
    Layman::Overlay['rabe-portage-overlay'] ~> Webapp_config['mediawiki'] ~> package { 'mediawiki-ext-ldap-auth':
      ensure => installed,
      before => Anchor['mediawiki::end']
    }
  }

  if $mediawiki_socialprofile == true {
    Layman::Overlay['rabe-portage-overlay'] ~> Webapp_config['mediawiki'] ~> package { 'mediawiki-ext-socialprofile':
      ensure => installed,
      before => Anchor['mediawiki::end']
    }
  }

  if $mediawiki_main_cache_type == 'CACHE_MEMCACHED' {
    Package['mediawiki'] ~> package { 'memcached':
      ensure => installed
    } ~> service { 'memcached':
      ensure => running,
      before => Anchor['mediawiki::end']
    }
  }

  anchor { 'mediawiki::end':
  }

}
