# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include rustup::config
class rustup::config {

  exec { "rustup set profile ${rustup::profile}":
    path        => ["${rustup::home_folder}/.cargo/bin/",],
    user        => $rustup::user,
    environment => ["HOME=${rustup::home_folder}"],
  }

  $rustup::targets.each |String $target| {

    # Per target dependencies
    case $target {
      'x86_64-unknown-linux-gnu': {
        package { [ 'build-essential' ]:
          ensure  => present,
        }
      }
      default: {
        fail("Unsupported target: ${target}")
      }
    }

    $rustup::releases.each |String $release| {
      exec { "rustup install ${release}-${target}":
        path        => ["${rustup::home_folder}/.cargo/bin/",],
        user        => $rustup::user,
        environment => ["HOME=${rustup::home_folder}"],
        require     => Exec["rustup set profile ${rustup::profile}"]
      }
    }
  }
}
