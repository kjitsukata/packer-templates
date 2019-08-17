require 'spec_helper'

%w{sshd vboxadd-service vboxadd}.each do |srv|
  describe service(srv), :if => os[:family] == 'redhat' do
    it { should be_enabled }
    it { should be_running }
  end
end

describe port(22) do
  it { should be_listening }
end
