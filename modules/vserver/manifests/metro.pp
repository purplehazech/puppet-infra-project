# Class: vserver::metro
#
# provision a metro live build vserver

class vserver::metro {
    require ::git
    require ::metro
}
