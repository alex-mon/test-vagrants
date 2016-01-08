class hue::install(
  $hue_releases_archive_url,
  $hue_release_package_file,
  $hue_release_package_folder,
  $hue_install_dir,
  $install_java_jdk,
  $hue_log_dir,
) {

  $common_packages = [ 'wget', 'ant', 'gcc', 'make', 'maven', 'git' ]
  $working_dir     = '/tmp'
  $local_repo_dir  = "${working_dir}/hue"

  case downcase($::osfamily) {
    'redhat': {
      $os_specific_packages = [ 'asciidoc', 'cyrus-sasl-devel', 'cyrus-sasl-gssapi', 'gcc-c++', 'krb5-devel', 'libxml2-devel',
        'libxslt-devel', 'mariadb', 'mariadb-devel', 'openldap-devel', 'python-devel', 'sqlite-devel', 'openssl-devel', 'gmp-devel', 'cyrus-sasl-plain', ] #, 'cyrus-sasl-gssapi'
    }

    default: {
      fail("The OS family ${::osfamily} is not yet supported.")
    }
  }

  package{ $common_packages:
    ensure => present,
  }

  package{ $os_specific_packages:
    ensure => present,
  }

  if $install_java_jdk {
    class { 'jdk_oracle':
      version => '8',
      default_java => 'true',
    }
  }

  exec { 'download_hue_package':
    command => "/usr/bin/wget ${hue_releases_archive_url}/${hue_release_package_file}",
    cwd     => $working_dir,
    creates => "${working_dir}/${hue_release_package_file}",
  }

  exec { 'decompress_hue_package':
    command => "/usr/bin/tar -zxvf ${hue_release_package_file}",
    cwd     => $working_dir,
    creates => "${working_dir}/${hue_release_package_folder}",
    require => Exec['download_hue_package'],
  }

  exec { 'install_hue':
    # In case of ssl problems... MAVEN_OPTS='-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true'
    command => '/usr/bin/make install',
    cwd     => "${working_dir}/${hue_release_package_folder}",
    creates => $hue_install_dir,
    timeout => '900',
    require => Exec['decompress_hue_package'],
  }

  user { 'hue':
    ensure => present,
    name   => 'hue',
    require => Exec['install_hue'],
  }

  # Set hue as the owner of the install dir
  file { "${hue_install_dir}":
    ensure  => directory,
    recurse => 'true',
    owner   => 'hue',
    group   => 'hue',
    require => User['hue'],
  }

  file { "${hue_log_dir}":
    ensure => directory,
    owner => 'hue',
    group => 'hue',
    require => User['hue'],
  }

  # Change the logs dir to our desired path
  file { "${hue_install_dir}/logs":
    ensure => 'link',
    owner  => 'hue',
    group  => 'hue',
    force  => 'true',
    target => $hue_log_dir,
    require => File["${hue_log_dir}"],
  }

 # TO-DO: INSTALL LIVI SERVER /tmp/hue/apps/spark/java && mvn -DskipTests -Dspark.version=1.4.1 -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true clean package
 # TO-DO: FIND A WQAY TO INSTALL SQOOP2 OR MAKE IT WORK WITH THE CURRENT HDP'S SQOOP DISTRIBUTION
}
