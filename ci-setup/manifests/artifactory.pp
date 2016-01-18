class { 'artifactory::config' :
  version       => '4.4.0',
  user          => 'artifactory',
  group         => 'artifactory',
  port          => 9292,
  manage_java   => false,
}

include artifactory
