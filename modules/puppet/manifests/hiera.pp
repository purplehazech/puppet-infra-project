# == Class: puppet::hiera
# 
class puppet::hiera inherits puppet:params {
  package { 'hiera':
    ensure   => absent,
    provider => 'gem';
  }
  package { 'hiera-puppet':
    ensure   => absent,
    provider => 'gem'
  }
  # create links for including hiera
  file { '/usr/share/puppet-infra-project/modules/hiera':
    ensure  => absent,
    target  => '/usr/local/lib64/ruby/gems/1.8/gems/hiera-puppet-1.0.0/',
    require => Package['hiera-puppet'],
    notify  => Service['puppet']
  }
}
