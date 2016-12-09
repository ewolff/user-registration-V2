#
# Cookbook Name:: tomcat
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default["tomcat"]["port"] = 8080
default["tomcat"]["ssl_port"] = 8443
default["tomcat"]["ajp_port"] = 8009
default["tomcat"]["java_options"] = "-Xmx128M -Djava.awt.headless=true"
default["tomcat"]["use_security_manager"] = false

default["tomcat"]["user"] = "tomcat7"
default["tomcat"]["group"] = "tomcat7"
default["tomcat"]["home"] = "/usr/share/tomcat7"
default["tomcat"]["base"] = "/var/lib/tomcat7"
default["tomcat"]["config_dir"] = "/etc/tomcat7"
default["tomcat"]["log_dir"] = "/var/log/tomcat7"
default["tomcat"]["tmp_dir"] = "/tmp/tomcat7-tmp"
default["tomcat"]["work_dir"] = "/var/cache/tomcat7"
default["tomcat"]["context_dir"] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
default["tomcat"]["webapp_dir"] = "/var/lib/tomcat7/webapps"
