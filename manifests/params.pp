/*

== Class: reprepro::params

Global parameters

*/
class reprepro::params {

  $ensure  = present
  $basedir = '/var/packages'
  $homedir = $basedir

  case $::osfamily {
    Debian: {
      $package_name = 'reprepro'
      $user_name    = 'reprepro'
      $group_name   = 'reprepro'
    }
  }

}
