# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include rustup::install
class rustup::install {

  user { $rustup::user:
    ensure => present,
    home   => $rustup::home_folder,
  }

  # Needed to download installation script
  package { 'curl':
    ensure => present,
  }

  $install_script = '/tmp/rustup-init.sh'

  exec { 'rustup-init download':
    command => "curl --proto \'=https\' --tlsv1.2 -sSf ${rustup::install_url} -o ${install_script}",
    user    => $rustup::user,
    creates => $install_script,
    path    => ['/usr/bin', '/usr/sbin',],
    require => Package['curl'],
  }

  exec { 'rustup-init run':
    command     => "bash ${install_script} -y --default-toolchain none",
    path        => ['/usr/bin', '/usr/sbin', '/bin',],
    user        => $rustup::user,
    environment => ["HOME=${rustup::home_folder}"],
    require     => Exec['rustup-init download'],
    onlyif      => "test -r ${install_script} && test ! -x ${rustup::home_folder}/.cargo/bin/rustup",
  }

}
