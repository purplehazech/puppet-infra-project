
class sudo {
    package {
        "sudo":
            ensure => installed
    }
}

import "*.pp"
