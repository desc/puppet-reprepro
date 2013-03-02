class reprepro (
  $basedir = $::reprepro::params::basedir
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
    home    => $basedir,
    shell   => '/bin/bash',
    comment => 'reprepro base directory',
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

  file { "${basedir}/.gnupg":
    ensure  => directory,
    owner   => $::reprepro::params::user_name,
    group   => $::reprepro::params::group_name,
    mode    => '0700',
    require => File[$basedir],
  }

}

