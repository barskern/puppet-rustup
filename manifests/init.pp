
class rustup (
  String $user,
  Stdlib::HTTPSUrl $install_url,
) {
  $home_folder = "/home/${rustup::user}"

  contain rustup::install
  contain rustup::config

  Class['rustup::install'] -> Class['rustup::config']
}
