require 'spec_helper'

%w{gcc make perl kernel-headers kernel-devel curl wget git epel-release dkms}.each do |pkg|
  describe package(pkg), :if => os[:family] == 'redhat' do
    it { should be_installed }
  end
end
