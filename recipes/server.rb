marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

include_recipe 'gluster::server'

include_recipe 'rightscale_tag::default'

machine_tag 'gluster:server=true' do
  action :create
end

machine_tag "gluster:unique=#{node['rsc_gluster']['unique']}" do
  action :create
end
