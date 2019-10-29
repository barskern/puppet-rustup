
class rustup (
  String $user,
  Stdlib::HTTPSUrl $install_url,
  Array[String] $releases,
  Array[String] $targets,
  String $profile,
) {
  $home_folder = "/home/${rustup::user}"

  contain rustup::install
  contain rustup::config

  Class['rustup::install'] -> Class['rustup::config']
}
