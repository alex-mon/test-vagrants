class hue::config (
    $hue_config_file,
    $config_values,
){
  file { "${hue_config_file}":
     ensure  => present,
     require => Class['hue::install'],
  }

  $defaults = { 'path' => "${hue_config_file}" }
  create_ini_settings($config_values, $defaults)
}
