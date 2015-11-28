name             "tomcat"
maintainer       "Eberhard Wolff based on Opscode"
maintainer_email "eberhard.wolff@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures tomcat"
version          "0.10.3"

depends "java"

supports "ubuntu"

recipe "tomcat::default", "Installs and configures Tomcat"
