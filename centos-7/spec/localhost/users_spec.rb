require 'spec_helper'

describe user('vagrant') do
  it { should exist }
end

describe user('vagrant') do
  it { should have_uid 501 }
end

describe user('vagrant') do
  it { should belong_to_group 'vagrant' }
  it { should belong_to_group 'wheel' }
end
