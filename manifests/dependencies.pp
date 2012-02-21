
class pythonbrew::dependencies {
  require => Anchor['pythonbrew::begin'],
  case $operatingsystem {
      Ubuntu,Debian: { require pythonbrew::dependencies::debian }
      CentOS,RedHat: { require pythonbrew::dependencies::centos }
    }
}
