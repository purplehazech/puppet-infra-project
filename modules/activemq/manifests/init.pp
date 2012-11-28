# == Class activemq
#
# simple class to install activemq from the oSSDL overlay
#
class activemq {

  layman::overlay{ 'OSSDL': }
  ->
  package { 'apache-activemq': ensure => installed }
  ->
  service { 'activemq': ensure => running }
 
}
