marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

<<<<<<< HEAD
require 'mixlib/shellout'

=======
>>>>>>> cd6c95d0b4da5da30a7fb87f23eb6ddf47264394
class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe "machine_tag::default"
tags = tag_list(node)
glusterfs_peers = []
tags_results = tag_search(node, "gluster:server=true").first
Chef::Log.info "tags:" + tags_results.inspect

tags_results.each do |itemlist|
    glusterfs_peers << itemlist["server:private_ip_0"].first.split('=').last
    Chef::Log.info " Here are the ips addresses that we got from ruby block of gluster peer " + itemlist["server:private_ip_0"].first.split('=').last
end

#Chef::Log.info "found peers #{glusterfs_peers}"

#node.override['gluster']['peers'] = #{glusterfs_peers}

#Chef::Log.info "Gluster Peers #{node['gluster']['peers']}"

#include_recipe "gluster::server-peer-probe"
