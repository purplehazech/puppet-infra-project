# == Class: gentoo:vnkuznet
#
# install vnkuznet repo in layman
#
# @deprecated use layman::overlay { 'gentoo-vnkuznet-overlay': }
#
class gentoo::vnkuznet {
  layman::overlay { 'gentoo-vnkuznet-overlay': }

}
