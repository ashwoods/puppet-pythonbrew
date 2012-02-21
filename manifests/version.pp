define pythonbrew::define::version (
    $ensure  => 'present',
    $default => 'false',
    $test    => 'false',
    ) {

    require => Anchor['pythonbrew::end']

    if $ensure == 'present' {
        exec { "install-python-${name}":
            command => "pythonbrew install ${name} -n",
            unless  => "pythonbrew list | grep ${name}",
            timeout => '0',
            require => Anchor['pythonbrew::end'],
            user    => $user,
        }

    }
}
