class hadoop {
  $hadoop_home = "/opt/hadoop"

  exec { "download_hadoop":
    # pick a mirror closest to you: http://www.apache.org/dyn/closer.cgi
    command => "wget -O /tmp/hadoop.tar.gz http://apache.mirrors.pair.com/hadoop/common/hadoop-1.1.2/hadoop-1.1.2.tar.gz",
#    command => "wget -O /tmp/hadoop.tar.gz http://apache.openmirror.de/hadoop/common/hadoop-1.1.2/hadoop-1.1.2.tar.gz",
    path => $path,
    unless => "ls /opt | grep hadoop-1.1.2",
    require => Package["openjdk-6-jdk"]
  }

  exec { "unpack_hadoop" :
    command => "tar xf /tmp/hadoop.tar.gz -C /opt",
    path => $path,
    creates => "${hadoop_home}-1.1.2",
    require => Exec["download_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/slaves":
      source => "puppet:///modules/hadoop/slaves",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/masters":
      source => "puppet:///modules/hadoop/masters",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/core-site.xml":
      source => "puppet:///modules/hadoop/core-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/mapred-site.xml":
      source => "puppet:///modules/hadoop/mapred-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/hdfs-site.xml":
      source => "puppet:///modules/hadoop/hdfs-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}-1.1.2/conf/hadoop-env.sh":
      source => "puppet:///modules/hadoop/hadoop-env.sh",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file { "/etc/profile.d/hadoop-path.sh":
    source => "puppet:///modules/hadoop/hadoop-path.sh",
    owner => root,
    group => root,
  }

}
