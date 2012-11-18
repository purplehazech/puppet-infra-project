# == Class: mediawiki
#
# === Parameters:
# [*mediawiki_sitename*]
#   wgSitename
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
#
class mediawiki {
  $mediawiki_raw_html               = true
  $mediawiki_disable_unauthed_edits = true
  $mediawiki_file_extensions        = ['svg', 'pdf', 'ppt', 'xls', 'dia']
  $mediawiki_remote_auth            = true
  $mediawiki_ldap_auth              = true

  file {
    '/etc/portage/package.use/10_php_xmlreader':
      content => 'dev-lang/php xmlreader';

    '/etc/portage/package.use/10_mediawiki_mysql':
      content => 'www-apps/mediawiki mysql';

    '/etc/portage/package.use/10_mediawiki_vhosts':
      content => 'www-apps/mediawiki vhosts';

    '/etc/portage/package.use/10_mediawiki_imagemagick':
      content => 'www-apps/mediawiki imagemagick';

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
}

