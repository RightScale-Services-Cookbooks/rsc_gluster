marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe "machine_tag::default"

glusterfs_peers = []
tags_results = tag_search(node, "gluster:server=true").first
Chef::Log.info "tags:" + tags_results.inspect

tags_results.each do |itemlist|
    Chef::Log.info " Here are the ips addresses that we got from ruby block of gluster peer " + itemlist["gluster:server=true"].first.split('=').last
    glusterfs_peers << itemlist["gluster:server=true"].first.split('=').last
end

#Chef::Log.info "found peers #{glusterfs_peers}"

#node.override['gluster']['peers'] = #{glusterfs_peers}

#Chef::Log.info "Gluster Peers #{node['gluster']['peers']}"

#include_recipe "gluster::server-peer-probe"
