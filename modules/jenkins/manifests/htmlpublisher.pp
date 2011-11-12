
class jenkins::htmlpublisher {
    exec {
        "install htmlpublisher plugin":
            command => "/usr/bin/jenkins-cli -s http://$ipaddress:8080 install-plugin htmlpublisher",
			creates => "/var/lib/jenkins/home/plugins/htmlpublisher.hpi",
            require => Service["/usr/bin/jenkins-cli"]
    }
}
