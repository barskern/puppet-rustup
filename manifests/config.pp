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

  # List with all the targets that need a specific setting regarding the linker
  $targets_and_prefixes = []

  $rustup::targets.each |String $target| {

    # Install per target dependencies
    #
    # Created based on https://github.com/japaric/rust-cross
    case $target {
      'x86_64-unknown-linux-gnu': {
        package { [ 'build-essential' ]:
          ensure  => present,
        }
      }
      'aarch64-unknown-linux-gnu': {
        package { [ 'gcc-aarch64-linux-gnu'
                  , 'libc6-arm64-cross'
                  , 'libc6-dev-arm64-cross'
                  ]:
          ensure => present,
        }

        $targets_and_prefixes << {
          name   => $target,
          prefix => 'aarch64-linux-gnu',
        }
      }
      /^arm(v7)?-unknown-linux-gnueabihf$/: {
        package { [ 'gcc-arm-linux-gnueabihf'
                  , 'libc6-armhf-cross'
                  , 'libc6-dev-armhf-cross'
                  ]:
          ensure => present,
        }

        $targets_and_prefixes << {
          name   => $target,
          prefix => 'arm-linux-gnueabihf',
        }
      }
      /^i686-unknown-linux-(musl|gnu)$/: {
        package { 'gcc-multilib':
          ensure => present,
        }
      }
      'x86_64-pc-windows-gnu': {
        package { 'gcc-mingw-w64':
          ensure => present
        }

        $targets_and_prefixes << {
          name   => $target,
          prefix => 'x86_64-w64-mingw32',
        }
      }
      'x86_64-unknown-linux-musl': {}
      'mipsel-unknown-linux-musl': {
        # TODO install openwrt sdk as done in https://github.com/japaric/rust-cross/blob/master/ci/install.sh
        fail("Unsupported target: ${target}")
      }
      default: {
        fail("Unsupported target: ${target}")
      }
    }

    file { "${rustup::home_folder}/.cargo/bin":
      ensure  => present,
      content => epp('cargo/config.epp', { targets => $targets_and_prefixes }),
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
