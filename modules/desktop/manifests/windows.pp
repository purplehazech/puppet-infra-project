
class desktop::windows {

    if $winCommonMusic != '' {
        registry_value { 
            'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\CommonMusic':
                ensure => present,
                type => string,
                data => $winCommonMusic
        }
    }

}

