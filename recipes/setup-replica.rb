marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'

Chef::Log.info 'Beginning gluster search'
glusterfs_peers = []
tags_results = tag_search(node, ["gluster:server=true","gluster:unique=#{node['rsc_gluster']['unique']}"], {match_all: true})
Chef::Log.info 'tags:' + tags_results.inspect

tags_results.each do |itemlist|
    ip_address = itemlist['server:private_ip_0'].first.split('=').last
    Chef::Log.info " Here are the ips addresses that we got from ruby block of gluster peer: #{ip_address}"
    glusterfs_peers << ip_address
end

Chef::Log.info "found peers #{glusterfs_peers}"

node.override['gluster']['peers'] = glusterfs_peers

Chef::Log.info "Gluster Peers #{node['gluster']['peers']}"

node.set['gluster']['brick']['path'] = node['rsc_gluster']['brick']['path']

include_recipe 'gluster::setup-replica'

remote_recipe "Gluster client - chef" do
  tags "gluster:server=true"
  attributes( {
  'GLUSTER_MOUNT_POINT' => 'text:/mnt/gluster',
  'GLUSTER_PEERS' => "text:#{glusterfs_peers}"
} )
  action :run
end
