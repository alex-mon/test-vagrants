class hue::supervisor(
  $hue_bin_dir,
){
  exec { 'launch_supervisor':
    command => "${hue_bin_dir}/supervisor -d",
    cwd     => $hue_bin_dir,
    user    => 'hue',
    require => Class['hue::config'],
  }
}
