machine_tag 'gluster:server=true' do
  action :delete
end

machine_tag "gluster:unique=#{node['rsc_gluster']['unique']}" do
  action :delete
end
