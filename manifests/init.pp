# Class: pythonbrew
#
# This module manages pythonbrew python's.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the nginx::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  stdlib
#    - puppetlabs-stdlib module >= 0.1.6
#    - plugin sync enabled to obtain the anchor type
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include pythonbrew
# }
class pythonbrew {

    if !defined(Class['stdlib']) {
            class { 'stdlib': }
    }

    class { 'pythonbrew::package':
        notify => Exec['pythonbrew::install'],
    }

    class { 'pythonbrew::params':
        require => Class['pythonbrew::package'],
        notify  => Exec['pythonbrew::install'],
  }

    exec {'pythonbrew::install':
        command => "curl -kL http://xrl.us/pythonbrewinstall | bash",
        require => Class['pythonbrew::package'],
        user    => $pythonbrew::params::user,
        unless  => "bash -l -c 'which pythonbrew'",

    }

    anchor {'pythonbrew::begin':
        before => Class['pythonbrew::package'],
        notify => Exec['pythonbrew::install']
    }
    anchor {'pythonbrew::end':
        require => Exec['pythonbrew::install'],
    }

}
