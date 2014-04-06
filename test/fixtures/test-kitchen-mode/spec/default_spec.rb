require_relative 'spec_helper'

describe 'test-kitchen-mode::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['lsb']['codename'] = 'raring'
    end.converge(described_recipe)
  end

  it 'should add the numix/ppa repository' do
    expect(chef_run).to add_apt_repository('numix/ppa')
  end
end
