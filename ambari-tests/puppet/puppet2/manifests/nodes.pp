node 'node-4.cluster' {

  $config_values = {
    'hadoop' => {
      'fs_defaultfs'            => 'hdfs://node-1.cluster:8020',
      'webhdfs_url'             => "http://node-1.cluster:50070/webhdfs/v1",
      'resourcemanager_host'    => "node-1.cluster",
      'resourcemanager_api_url' => "http://node-1.cluster:8088",
      'proxy_api_url'           => "http://node-1.cluster:8088",
      'history_server_api_url'  => "http://node-1.cluster:19888",
    },
    'desktop'   => {
      'app_blacklist' => 'impala ',
      'secret_key'    => 'Ghfdas47543;&%$·"!jfdaNJFRqhj53;;jfdaio38549**@Mz<joe5',
    },
    'liboozie'  => { 'oozie_url'        => "http://node-4.cluster:11000/oozie", },
    'beeswax'   => { 'hive_server_host' => 'node-4.cluster', },
    'sqoop'     => { 'server_url'       => "http://node-4.cluster:12000/sqoop", },
    'hbase'     => { 'hbase_clusters'   => "(node-4.cluster|node-4.cluster:9090)", },
    'zookeeper' => { 'host_ports'       => "node-3.cluster:2181", },
    'spark'     => { 'server_url'       => "http://node-4.cluster:8090", },
  }

  class { 'hue':
    config_values => $config_values,
  }
}
