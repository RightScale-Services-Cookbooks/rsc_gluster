rightscale_marker :begin

include_recipe "gluster::server"

right_link_tag "gluster:server=true" do
  action :publish
end

rightscale_marker :end
