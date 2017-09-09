require "spec_helper"
require "serverspec"

package = "git-repository"
service = "git-repository"
config  = "/etc/git-repository/git-repository.conf"
user    = "git-repository"
group   = "git-repository"
ports   = [PORTS]
log_dir = "/var/log/git-repository"
db_dir  = "/var/lib/git-repository"

case os[:family]
when "freebsd"
  config = "/usr/local/etc/git-repository.conf"
  db_dir = "/var/db/git-repository"
end

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("git-repository") }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/git-repository") do
    it { should be_file }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
