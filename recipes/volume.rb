marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'

Chef::Log.info 'Beginning gluster search'
glusterfs_peers = []
tags_results = tag_search(node, 'gluster:server=true')
Chef::Log.info 'tags:' + tags_results.inspect

tags_results.each do |itemlist|
    ip_address = itemlist['server:private_ip_0'].first.split('=').last
    Chef::Log.info " Here are the ips addresses that we got from ruby block of gluster peer: #{ip_address}"
    glusterfs_peers << ip_address
end

Chef::Log.info "found peers #{glusterfs_peers}"

node.override['gluster']['peers'] = glusterfs_peers

rsc_remote_recipe "attach local client" do
  recipe "rs-storage::volume"
  recipient_tags "gluster:server=true"
  action :run
end
