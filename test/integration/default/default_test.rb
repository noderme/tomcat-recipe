# # encoding: utf-8

# Inspec test for recipe apache::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


describe package ('openjdk-8-jdk') do
  it { should be_installed }
end

describe group ('tomcat') do
  it { should exist }
end

describe user ('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
end

describe service ('tomcat') do
  it { should be_running }
end