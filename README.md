# vagrant-ambari-cluster
 
This vagrant file will deploy a cluster with an ambari-server and up to 9 nodes with the ambari-agent service installed

By default, the machines will have 2Gb of Ram.

In order to change the number of ambari-agent nodes, you will need to edit the *VagrantFile* and change the parameter named *cluster_size*

>cluster_size = 1

###The default ips and fqdn for the nodes are:
  - **Ambari-Server:** 
    - ambarimaster.cluster
    - 192.168.0.10
  - **Slave nodes:**  
    - node-x.cluster       
    - 192.168.0.1x *Where "x" is the node number*

# How to create the cluster using Vagrant and VirtualBox

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads "VirtualBox Downloads")
2. Download and install [Vagrant](https://www.vagrantup.com/downloads.html "Vagrant Downloads")
3. Open a console and navigate to the folder where the *Vagrantfile* file is located
4. Run the command `vagrant up` to launch the machines creation and provision.
5. Once the process finishes, the [Ambari UI](http://192.168.0.10:8080 "Ambari") should be accessible
6. It's possible to suspend and resume the cluster machines using the commands `vagrant suspend` and `vagrant resume`
7. To ssh into the nodes: `ssh node-x.cluster`
8. To destroy the cluster use the command `vagrant destroy`

# Deploying a cluster using Blueprints
With ambari, there are two ways to deploy a cluster. 
- The first and simplest way to do it is using the assisted wizards of the ambari web.
- The second way to deploy is through [Ambari Blueprints](https://cwiki.apache.org/confluence/display/AMBARI/Blueprints "Ambari Blueprints"). There is a simple example in the `ambari_blueprint_provision` folder.
