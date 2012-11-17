# == Class: mediawiki
#
class mediawiki {
  file {
    '/etc/portage/package.use/10_php_xmlreader':
      content => 'dev-lang/php xmlreader';

    '/etc/portage/package.use/10_mediawiki_mysql':
      content => 'www-apps/mediawiki mysql';

    '/etc/portage/package.use/10_mediawiki_vhosts':
      content => 'www-apps/mediawiki vhosts';

    '/etc/portage/package.use/10_mediawiki_imagemagick':
      content => 'www-apps/mediawiki imagemagick';

    '/var/www/$fqdn/htdocs/LocalSettings.php':
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
}
   
   
