marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe "machine_tag::default"

glusterfs_peers = Array.new
tags = tag_search(node, "gluster:server=true").first
Chef::Log.info "tags:" + tags.inspect

glusterfs_peers = Array.new
tags.each do |itemlist|
  block do
    glusterfs_peers << itemlist["server:private_ip_0"].first.split('=').last
    Chef::Log.info " Here are the ips addresses that we got from ruby block of gluster peer " + itemlist["server:private_ip_0"].first.split('=').last
  end
end


Chef::Log.info "found peers #{glusterfs_peers}"

node.override['gluster']['peers'] = #{glusterfs_peers}

Chef::Log.info "Gluster Peers #{node['gluster']['peers']}"

include_recipe "gluster::server-peer-probe"
