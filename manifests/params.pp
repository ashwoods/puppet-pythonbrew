# Class: nginx::params
#
# This module manages pythonbrew paramaters
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class pythonbrew::params {
  $user       = 'root'
  $build_cmd  = 'sudopybrew install -n --no-setuptools --configure="--with-threads --enable-shared" -j2 -v'
  $default    = true
}
