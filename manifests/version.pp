# define: pythonbrew::version
#
# This definition creates a new upstream proxy entry for NGINX
#
# Parameters:
#   [*ensure*]      - Enables or disables a python (present|absent)
#   [*default*]     - If a switch is called after installation (true|false)
#   [*test*]        - Pythonbrew build with tests (true|false)
#   [*user*]        - Which user is to run the installation
# Actions:
#
# Requires:
#
# Sample Usage:
#  pythonbrew::version { '2.7.2':
#    ensure  => present,
#    default => true,
#
# }


define pythonbrew::version (
    $ensure  = 'present',
    $default = 'true',
    $test    = 'false',
    $user    = 'root'
    ) {

    if $ensure == 'present' {
        exec { "install-python-${name}":
            command => "bash -l -c '${pythonbrew::params::build_cmd} ${name}'",
            unless  => "bash -l -c 'pythonbrew list | grep ${name}'",
            timeout => '0',
            require => Anchor['pythonbrew::end'],
            user    => $user,
        }

        exec { "ld-config-${name}":
            command => "echo /usr/local/pythonbrew/pythons/Python-${name}/lib/ >> /etc/ld.so.conf.d/pythonbrew.${name}.conf && ldconfig",
            creates => "/etc/ld.so.conf.d/pythonbrew.${name}.conf",
            require => Exec["install-python-${name}"],

        }
        exec { "curl-distribute-${name}":
            command => "curl -O http://python-distribute.org/distribute_setup.py",
            cwd     => "/root",
            creates => "/root/distribute_setup.py",
            require => Package['curl'],

        }

        # Thus is needed as we are installing pythonbrew with --no-setuptools due to using libs
        exec {"install-distribute-${name}":
            command => "bash -l -c 'pythonbrew use ${name} && python distribute_setup.py && easy_install pip'",
            cwd     => "/root",
            unless  => "bash -l -c 'pythonbrew use ${name} && which pip | grep pythonbrew'",
            require => Exec["curl-distribute-${name}","ld-config-${name}","curl-distribute-${name}"]
        }

        exec {"install-virtualenv-${name}":
            command => "bash -l -c 'pythonbrew use ${name} && pip install virtualenv virtualenvwrapper fabric'",
            # as it has to compile pycrypto
            timeout => '0',
            # making it easy on us, for now just checking for fabric
            unless  => "bash -l -c 'pythonbrew use ${name} && which fab'",
            require => Exec["install-distribute-${name}"]
        }



    }

    if $default == 'true' {
        exec {"make-${name}-default":
            command => "bash -l -c 'pythonbrew switch ${name}'",
            require => Exec["install-python-${name}"]
        }
    }

}
