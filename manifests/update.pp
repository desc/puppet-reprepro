/*
== Definition: reprepro::update
Adds a packages repository.

Parameters:
- *name*: the name of the update-upstream use in the Update field in conf/distributions
- *ensure*: present/absent, defaults to present
- *url*: a valid repository URL
- *verify_release*: check the GPG signature Releasefile
- *filter_action*: default action when something is not found in the list
- *filter_name*: a list of filenames in the format of dpkg --get-selections

Requires:
- Class["reprepro"]

Example usage:

  reprepro::update {"lenny-backports":
    ensure      => present,
    repository  => "dev",
    url         => 'http://backports.debian.org/debian-backports',
    filter_name => "lenny-backports",
  }

*/
define reprepro::update (
  $suite,
  $repository,
  $url,
  $basedir = $::reprepro::params::basedir,
  $ensure = present,
  $architectures = undef,
  $verify_release = 'blindtrust',
  $filter_action = '',
  $filter_name = ''
) {

  include reprepro::params
  include concat::setup

  if $filter_name != '' {
    if $filter_action == '' {
      $filter_list = "deinstall ${filter_name}-filter-list"
    } else {
      $filter_list = "${filter_action} ${filter_name}-filter-list"
    }
  } else {
    $filter_list = ''
  }

  $manage = $ensure ? {
    present => false,
    default => true,
  }

  concat::fragment {"update-${name}":
    ensure  => $ensure,
    content => template('reprepro/update.erb'),
    target  => "${basedir}/${repository}/conf/updates",
    require => $filter_name ? {
      ''      => undef,
      default => Reprepro::Filterlist[$filter_name],
    }
  }

}
