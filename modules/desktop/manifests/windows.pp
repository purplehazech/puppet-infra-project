
class desktop::windows {

    if $winCommonMusic != '' {
        /** off due to no pluginsync on windows agent in our version
        registry_value { 
            'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\CommonMusic':
                ensure => present,
                type => string,
                data => $winCommonMusic
        }
        **/
    }

}

