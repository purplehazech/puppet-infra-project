# == Class: puppet::hiera
#
# hiera installation
#
# I still need to rollut hiera, this is just a smallish start
#
class puppet::hiera inherits puppet::params {
  file { '/etc/hiera.yaml': content => template('puppet/hiera.yaml.erb') }

  package { 'hiera':
    ensure   => absent,
    provider => 'gem'
  }

  package { 'hiera-puppet':
    ensure   => absent,
    provider => 'gem'
  }

  # create links for including hiera
  file { '/usr/share/puppet/modules/hiera':
    ensure  => absent,
    target  => '/usr/local/lib64/ruby/gems/1.8/gems/hiera-puppet-1.0.0/',
    require => Package['hiera-puppet'],
    notify  => Service['puppet']
  }
}
