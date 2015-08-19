marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

include_recipe "gluster::server"

machine_tag "gluster:server=true" do
  action :create
end
