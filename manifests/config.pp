# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include rustup::config
class rustup::config {

  # The rustup command will ensure that the toolchain is installed and updated.
  exec { "rustup install ${facts['rust_toolchain']}":
    path        => ["${rustup::home_folder}/.cargo/bin/",],
    user        => $rustup::user,
    environment => ["HOME=${rustup::home_folder}"],
  }

  # Ensure the installed toolchain is the default
  exec { "rustup default ${facts['rust_toolchain']}":
    path        => ["${rustup::home_folder}/.cargo/bin/",],
    user        => $rustup::user,
    environment => ["HOME=${rustup::home_folder}"],
    require     => Exec["rustup install ${facts['rust_toolchain']}"],
  }
}
