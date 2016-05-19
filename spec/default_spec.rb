require_relative 'spec_helper'

describe 'rsc_gluster::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
    end.converge(described_recipe)
  end

  it 'includes gluster default' do
    expect(chef_run).to include_recipe('gluster::default')
  end
end
