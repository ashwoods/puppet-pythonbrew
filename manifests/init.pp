
class pythonbrew($user='root') {
    anchor {'pythonbrew::begin'}
    anchor {'pythonbrew::end'}

    exec {'pythonbrew::install':
        command => "curl -kL http://xrl.us/pythonbrewinstall | bash",
        require => Class['pythonbrew::dependencies'],
        user    => $user,
  }
}
