# == Class: hue
#
# This class will download, build and configure Cloudera's HUE
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { 'hue':
#
#  }
#
# === Authors
#
# Alejandro Montero <alejandro.montero@veinteractive.com>
#
class hue (
    $hue_install_dir            = $hue::params::hue_install_dir,
    $hue_releases_archive_url   = $hue::params::hue_releases_archive_url,
    $hue_release_package_file   = $hue::params::hue_release_package_file,
    $hue_release_package_folder = $hue::params::hue_release_package_folder,
    $install_java_jdk           = $hue::params::install_java_jdk,
    $hue_config_file            = $hue::params::hue_config_file,
    $config_values              = $hue::params::config_values,
    $hue_bin_dir                = $hue::params::hue_bin_dir,
    $hue_log_dir                = $hue::params::hue_log_dir,
    $install_java_jdk           = $hue::params::install_java_jdk,
) inherits hue::params {

    anchor { 'hue::begin': } ->
    class { 'hue::install':
      hue_install_dir            => $hue_install_dir,
      hue_releases_archive_url   => $hue_releases_archive_url,
      hue_release_package_file   => $hue_release_package_file,
      hue_release_package_folder => $hue_release_package_folder,
      install_java_jdk           => $install_java_jdk,
      hue_log_dir                => $hue_log_dir,
    } ->
    class { 'hue::config':
      hue_config_file => $hue_config_file,
      config_values   => $config_values,
    } ->
    class { 'hue::supervisor':
      hue_bin_dir => $hue_bin_dir,
    } ->
    anchor { 'hue::end': }

}
