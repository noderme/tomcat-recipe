#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update

apt_package "openjdk-8-jdk"

group 'tomcat' do
  end

user 'tomcat' do
    group 'tomcat'
    home '/opt/tomcat'
    shell '/bin/false'
  end  

  remote_file 'apache-tomcat-9.0.20.tar.gz' do
    source 'http://mirror.cc.columbia.edu/pub/software/apache/tomcat/tomcat-9/v9.0.20/bin/apache-tomcat-9.0.20.tar.gz'
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
    action :create
  end  

directory 'opt/tomcat/' do
  group 'tomcat'
end

execute "sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1"

execute "sudo chgrp -R tomcat /opt/tomcat"

execute "sudo chmod -R g+r /opt/tomcat/conf"

execute "sudo chmod g+x /opt/tomcat/conf"

execute "sudo chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/"

template "/etc/systemd/system/tomcat.service" do
    source 'apache.erb'
    owner 'tomcat'
end    

apt_update

execute "sudo systemctl daemon-reload"

service "tomcat" do
  action [ :enable, :start ]
end  