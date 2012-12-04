/*
== Definition: reprepro::filterlist

Adds a FilterList

Parameters:
- *name*: name of the filter list
- *ensure*: present/absent, defaults to present
- *repository*: the name of the repository
- *packages*: a list of packages

Requires:
- Class["reprepro"]

Example usage:

  reprepro::filterlist {"lenny-backports":
    ensure     => present,
    repository => "dev",
    packages   => [
    "git install",
    "git-email install",
    "gitk install",
    ],
  }

Warning:
- Packages list have the same syntax as the output of dpkg --get-selections

*/
define reprepro::filterlist (
  $repository,
  $packages,
  $ensure=present
) {

  include reprepro::params

  file {"${reprepro::params::basedir}/${repository}/conf/${name}-filter-list":
    ensure  => $ensure,
    owner   => 'root',
    group   => ${reprepro::params::group_name},
    mode    => '0664',
    content => template('reprepro/filterlist.erb'),
  }
}
