require "spec_helper"
require "serverspec"

describe file("/tmp/should_not_exist") do
  it { should_not exist }
end
