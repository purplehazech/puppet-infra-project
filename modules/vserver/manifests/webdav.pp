class vserver::webdav {
    webdavcgi {
        'webdav':
            hostname => $webdav_hostname,
            docroot  => $webdav_docroot,
            ldap    => true;
    }
}
