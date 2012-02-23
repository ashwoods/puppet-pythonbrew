# Class: pythonbrew::dependencies
#
# Takes care of system dependencies
# Currently only works for ubuntu/debian
# patches for centos and suse welcome

class pythonbrew::package {
  anchor { 'pythonbrew::package::begin': }
  anchor { 'pythonbrew::package::end': }

  case $::operatingsystem {
    centos,fedora,rhel: {
      class { 'pythonbrew::package::redhat':
        require => Anchor['pythonbrew::package::begin'],
        before  => Anchor['pythonbrew::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'pythonbrew::package::debian': 
        require => Anchor['pythonbrew::package::begin'],
        before  => Anchor['pythonbrew::package::end'],
      }
    }
    opensuse,suse: {
      class { 'pythonbrew::package::suse':
        require => Anchor['pythonbrew::package::begin'],
        before  => Anchor['pythonbrew::package::end'],
      }
    }
  }
}
