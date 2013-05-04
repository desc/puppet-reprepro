class reprepro (
  $basedir = $::reprepro::params::basedir,
  $homedir = $::reprepro::params::homedir,
) inherits reprepro::params {

  package { $::reprepro::params::package_name:
    ensure => $::reprepro::params::ensure,
  }

  group { 'reprepro':
    name   => $::reprepro::params::group_name,
    ensure => present,
  }

  user { 'reprepro':
    name    => $::reprepro::params::user_name,
    ensure  => present,
    home    => $homedir,
    shell   => '/bin/bash',
    comment => 'Reprepro user',
    gid     => 'reprepro',
    require => Group['reprepro'],
  }

  file { $basedir:
    ensure  => directory,
    owner   => $::reprepro::params::user_name,
    group   => $::reprepro::params::group_name,
    mode    => '0755',
    require => User['reprepro'],
  }

  file { "${homedir}/.gnupg":
    ensure  => directory,
    owner   => $::reprepro::params::user_name,
    group   => $::reprepro::params::group_name,
    mode    => '0700',
    require => User['reprepro'],
  }

}

