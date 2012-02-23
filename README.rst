Pythonbrew module for puppet
============================

Currently it only supports installing pythonbrew as user root (systemwide pythonbrew install)
and it currently only supports debian/ubuntu based systems.

Tested on squeeze-amd64 with puppet 2.6.6


Pythonbrew?
----------

Pythonbrew lets you easily manage python installs side-by-side without touching the system pythons.

From the website:
    pythonbrew is a program to automate the building and installation of Python in the users $HOME.

    pythonbrew is inspired by perlbrew and rvm

For more information about pythonbrew, checkout the project website: https://github.com/utahta/pythonbrew.git


Puppet usage:
-------------


node default {

    exec {'apt-get update':}

    Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin" }
    Package { require => Exec['apt-get update'] }

    include pythonbrew

    pythonbrew::version {'2.7.2':
        user => 'vagrant', # chosing a user doesn't work right now
        default => 'true', # runs a pythonbrew switch to make it the default
    }
}


Out of the box it installs pythonbrew with no-tests run (tests more secure, but it takes for ever),
and with --enable-shared. Due to problems with pythonbrew, it installed following this procedure:
http://stackoverflow.com/a/8324176/471842
