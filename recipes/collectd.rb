user 'gfscheck' do
  comment 'gfscheck'
  system true
  shell '/sbin/nologin'
end

# TODO: replace  with __RS_INSTANCE_UUID__ and __RS_GLUSTER_MOUNT__
file '/usr/bin/gfsmountcheck.rb' do
  content '#!/usr/bin/env ruby
# Collection loop
while true do
  ls_status = system("ls __RS_GLUSTER_MOUNT__ 1> /dev/null 2>&1")
  pgrep_status = system("pgrep glusterfs 1> /dev/null 2>&1")

  # Convert to Collect Send-able-values
  if ls_status && pgrep_status
    status = 0
  else
    status = 1
  end
puts "PUTVAL __RS_INSTANCE_UUID__/gluster_mount/gauge-mount_point_errors #{Time.now.to_i}:#{status}"
  sleep 45
end'
  mode '0777'
  owner 'gfscheck'
  group 'gfscheck'
end


file node['rsc_gluster']['collectd']['directory']+'/gfsmountcheck.conf' do
  content '<Plugin exec>
  Exec "gfscheck" "/usr/bin/gfsmountcheck.rb"
</Plugin>'
  mode '0755'
  owner 'root'
  group 'root'
end

# TODO:  this needs to be modified to handle if RL10 is the monitoring daemon instead of collectd
service 'collectd' do
    action :restart
end