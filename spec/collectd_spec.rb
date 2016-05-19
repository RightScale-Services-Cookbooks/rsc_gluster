require_relative 'spec_helper'

describe 'rsc_gluster::collectd' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['rsc_gluster']['collectd']['directory'] = '/etc/collectd.d'
    end.converge(described_recipe)
  end
  it 'creates user for gfsmountcheck to run as: gfscheck' do
    expect(chef_run).to create_user('gfscheck').with(
      comment: 'gfs check user',
      shell: '/sbin/nologin',
      manage_home: false
    )
  end
  it 'creates /usr/bin/gfsmountcheck.rb' do
    expect(chef_run).to create_cookbook_file('/usr/bin/gfsmountcheck.rb').with(
      user: 'gfscheck',
      group: 'gfscheck',
      backup: false,
      mode: 0777
    )
  end
  it 'creates collectd config' do
    expect(chef_run).to create_cookbook_file("#{::File.join(chef_run.node['rsc_gluster']['collectd']['directory'],'gfsmountcheck.conf')}").with(
      user: 'root',
      group: 'root',
      backup: false
    )
  end
  it 'restarts collectd' do
    expect(chef_run).to restart_service('collectd')
  end
end
