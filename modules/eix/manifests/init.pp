# Define: eix
#
# install and manage eix
#
# This module is a bit silly since eix is already a dep for puppet.
# It used to take care of managing /etc/eixrc and I need it to 
# righten my silly idea of keeping a central eix-cache. Who knows
# maybe one-day i'll find a use for doing stuff to eixrc :)
# 
#
# Parameters:
# - ensure
#
# Actions:
# * Install eix package and manage eixrc
#
# Sample Usage:
# 
#      eix{ 'install':; }
#
define eix (
    $ensure = installed
) {

    package { "eix":
        ensure => $ensure
    }

    file {
        "/var/cache/eix":
            ensure => file;
        "/etc/eixrc":
            content => template("eix/eixrc.erb")
    }
}
