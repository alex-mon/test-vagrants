require 'spec_helper'
describe 'hue' do

  context 'with defaults for all parameters' do
    it { should contain_class('hue') }
  end
end
