What's
  - HiveServer2 - Thrift interface for hive
  - DRPC Server - The DRPC server coordinates receiving an RPC request, sending the request to the Storm topology, receiving the results from the Storm topology, and sending the results back to the waiting client.
  - Phoenix Query Server - The Phoenix Query Server provides an alternative means for interaction with Phoenix and HBase. Soon this will enable access from environments other than the JVM.
            Overview:
                Phoenix 4.4 introduces a stand-alone server that exposes Phoenix to “thin” clients. It is based on the Avatica component of Apache Calcite. The query server is comprised of a Java server that manages Phoenix Connections on the clients’ behalf. The client implementation is currently a JDBC driver with minimal dependencies. The transport mechanism is currently JSON encoded requests over HTTP transport. There’s also a sqlline script that uses the thin client.



Cluster Distribution

  +ambarimaster.testcluster.dom  
    Ambari Metrics
      Metrics Collector
      Metrics monitored

  +node-1.testcluster.dom (ACESS NODE + HCAT NODE)
    Storm
      DRPC server
      Storm UI Server
    hive
      Hive Metastore
      HiveServer2
      MySql server
      WebHCat server
    Oozie
      Oozie server
    Ambari Metrics
      Metrics monitored
    HDFS
      NFS Gateway
    HBase
      Phoenix Query server
    Clients
      HBase Client, HCAt Client, HDFS Client, Hive Client, MapRed2 Client, Oozie Client, Pig, Spark Client, Sqoop, Tez Client, YARN Client, Zookeeper Client


  +node-2.testcluster.dom (Master Hadoop Node)
    YARN  
      App Timeline server
      Resource manager
    HBase
      Active HBase Master
    MapReduce 2
      History server
    HDFS
      NameNode
      SNameNode
    Storm
      Nimbus
    Spark
      Spark History server
    Ambari Metrics
      Metrics monitor
    Clients (WTF!)
      Hdfs Client, MapReduce2 Client, Tez Client, YARN Client.

  +node-3.testcluster.dom (Slave Hadoop Node)
    YARN
      NodeManager
    HBase
      Regionserver
    HDFS
      DataNode
    Storm
      Supervisor
    Ambari Metrics
      Metrics Monitor

  +node-4.testcluster.dom (Kafka, Zookeeper, Flume)
    Kafka
      Kafka Broker
    Zookeeper
      Zookeeper server
    Flume
      Flume
    Ambari Metrics
      Metrics Monitor
