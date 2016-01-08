class hue::params {
  $hue_install_dir            = '/usr/local/hue'
  $hue_releases_archive_url   = 'https://dl.dropboxusercontent.com/u/730827/hue/releases/3.9.0'
  $hue_release_package_file   = 'hue-3.9.0.tgz'
  $hue_release_package_folder = 'hue-3.9.0'
  $hue_config_file            = '/usr/local/hue/desktop/conf/hue.ini'
  $hue_bin_dir                = '/usr/local/hue/build/env/bin'
  $hue_log_dir                = '/var/log/hue'
  $install_java_jdk           = 'true'

  # Cluster's config
  $config_values = {
    'hadoop' => {
      'fs_defaultfs'            => 'hdfs://node-1.cluster:8020',
      'webhdfs_url'             => "http://${::fqdn}:50070/webhdfs/v1",
      'resourcemanager_host'    => $::fqdn,
      'resourcemanager_api_url' => "http://${::fqdn}:8088",
      'proxy_api_url'           => "http://${::fqdn}:8088",
      'history_server_api_url'  => "http://${::fqdn}:19888",
    },
    'desktop'   => {
      'app_blacklist' => 'impala ',
      'secret_key'    => 'GFDSKgf90i54opjge809t5uy4jogi9n9v9vp4528mv90pu459vgfd$',
    },
    'liboozie'  => { 'oozie_url'        => "http://${::fqdn}:11000/oozie", },
    'beeswax'   => { 'hive_server_host' => $::fqdn, },
    'sqoop'     => { 'server_url'       => "http://${::fqdn}:12000/sqoop", },
    'hbase'     => { 'hbase_clusters'   => "(${::fqdn}|${::ipaddress}:9090)", },
    'zookeeper' => { 'host_ports'       => "${::fqdn}:2181", },
    'spark'     => { 'livy_server_host'       => "http://${::fqdn}:8090", },
  }

}
