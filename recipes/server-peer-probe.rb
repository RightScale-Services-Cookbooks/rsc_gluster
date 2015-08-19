marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

class Chef::Resource::RubyBlock
  include Chef::MachineTagHelper
end

include_recipe "machine_tag::default"

glusterfs_peers = Array.new
r=ruby_block "find server ip" do
  block do
    tags = tag_search(node, "gluster:server=true").first
    Chef::Log.info "tags: #{tags.inspect}"
    glusterfs_peers =  tags["server:private_ip_0"].first.value
  end
end
r.run_action(:create)

Chef::Log.info "found peers #{glusterfs_peers}"

node.override['gluster']['peers'] = glusterfs_peers

Chef::Log.info "Gluster Peers #{node['gluster']['peers']}"

include_recipe "gluster::server-peer-probe"
