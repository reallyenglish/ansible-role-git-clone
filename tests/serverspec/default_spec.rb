require "spec_helper"
require "serverspec"
require "uri"

default_user = "root"

url = "https://github.com/reallyenglish/ansible-role-example"
cloned = [
  { path: "/usr/local/git_clone/ansible-role-example",
    user: default_user,
    file_mode: 644,
    dir_mode: 755,
    remote: url },
  { path: "/usr/local/git_clone/update",
    user: default_user,
    file_mode: 644,
    dir_mode: 755,
    remote: url },
  { path: "/usr/local/git_clone/bin/repo",
    user: "bin",
    file_mode: 644,
    dir_mode: 755,
    remote: url },
  { path: "/usr/local/git_clone/umask",
    user: default_user,
    file_mode: 664,
    dir_mode: 775,
    remote: url }
]

cloned.each do |c|
  describe file(c[:path]) do
    it { should exist }
    it { should be_directory }
    it { should be_mode c[:dir_mode] }
    it { should be_owned_by c[:user] }
  end

  describe file("#{c[:path]}/README.md") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by c[:user] }
    it { should be_mode c[:file_mode] }
  end

  describe command("cd '#{c[:path]}' && git remote -v") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/^origin\s+#{Regexp.escape(c[:remote])} \(fetch\)$/) }
    its(:stdout) { should match(/^origin\s+#{Regexp.escape(c[:remote])} \(push\)$/) }
  end
end
