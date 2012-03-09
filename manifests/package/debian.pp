class pythonbrew::package::debian {

  if ! defined(Package['curl'])                 { package { 'curl':                 ensure => installed } }
  if ! defined(Package['build-essential'])      { package { 'build-essential':      ensure => installed } }

  if ! defined(Package['libgdbm-dev'])          { package { 'libgdbm-dev':          ensure => installed } }
  if ! defined(Package['libgdb-dev'])           { package { 'libgdb-dev':           ensure => installed } }

  if ! defined(Package['libbz2-dev'])           { package { 'libbz2-dev':           ensure => installed } }

  if ! defined(Package['libreadline6'])         { package { 'libreadline6':         ensure => installed } }
  if ! defined(Package['libreadline6-dev'])     { package { 'libreadline6-dev':     ensure => installed } }
  if ! defined(Package['zlib1g'])               { package { 'zlib1g':               ensure => installed } }
  if ! defined(Package['zlib1g-dev'])           { package { 'zlib1g-dev':           ensure => installed } }

  if ! defined(Package['openssl'])              { package { 'openssl':              ensure => installed } }
  if ! defined(Package['libssl-dev'])           { package { 'libssl-dev':           ensure => installed } }
  if ! defined(Package['libsqlite3-0'])         { package { 'libsqlite3-0':         ensure => installed } }
  if ! defined(Package['libsqlite3-dev'])       { package { 'libsqlite3-dev':       ensure => installed } }
  if ! defined(Package['sqlite3'])              { package { 'sqlite3':              ensure => installed } }

  if ! defined(Package['tk-dev'])               { package { 'tk-dev':               ensure => installed } }
  if ! defined(Package['libxml2'])              { package { 'libxml2':              ensure => installed } }
  if ! defined(Package['libxml2-dev'])          { package { 'libxml2-dev':          ensure => installed } }
  if ! defined(Package['libxslt1-dev'])         { package { 'libxslt1-dev':         ensure => installed, alias => 'libxslt-dev' } }
  if ! defined(Package['libexpat1-dev'])        { package { 'libexpat1-dev':        ensure => installed } }

  if ! defined(Package['autoconf'])             { package { 'autoconf':             ensure => installed } }
  if ! defined(Package['libc6-dev'])            { package { 'libc6-dev':            ensure => installed } }

  if ! defined(Package['libncursesw5-dev'])     { package { 'libncursesw5-dev':     ensure => installed } }

  # for PIP
  if ! defined(Package['git-core'])             { package { 'git-core':             ensure => installed } }
  if ! defined(Package['mercurial'])            { package { 'mercurial':            ensure => installed } }

  # for PIL
  if ! defined(Package['libfreetype6 '])        { package { 'libfreetype6':         ensure => installed } }
  if ! defined(Package['libfreetype6-dev'])     { package { 'libfreetype6-dev':     ensure => installed } }


  if ! defined(Package['libfreetype6-dev'])     { package { 'libfreetype6-dev':     ensure => installed } }

  # for postgresql

  if ! defined(Package['libpq-dev'])     { package { 'libpq-dev':     ensure => installed } }

  case $operatingsystem {
    ubuntu: { $libjpeg = "libjpeg62" }
    debian: { $libjpeg = "libjpeg8"  }
  }

  package {'libjpeg':
    name   => $libjpeg,
    ensure => installed
  }

  package {'libjpeg-dev':
    name   => "${libjpeg}-dev",
    ensure => installed
  }
}
