ruby_block "config attributes" do
  block do
    EXPORT_DIR=node['gluster']['brick']['path']
    require 'mixlib/shellout'
    log "doing attribute set"
    attr1=Mixlib::ShellOut.new("setfattr -x trusted.glusterfs.volume-id #{EXPORT_DIR}").run_command
    log "setfattr -x trusted.glusterfs.volume-id #{EXPORT_DIR} STDOUT: #{attr1.stdout} STDERR: #{attr1.stderr}"
    attr2=Mixlib::ShellOut.new("setfattr -x trusted.gfid #{EXPORT_DIR}").run_command
    log "setfattr -x trusted.gfid STDOUT: #{attr2.stdout} STDERR: #{attr2.stderr}"
    attr3=Mixlib::ShellOut.new("rm -fr #{EXPORT_DIR}/.glusterfs").run_command
    log "rm -fr #{EXPORT_DIR}/.glusterfs STDOUT: #{attr3.stdout} STDERR: #{attr3.stderr}"
  end
end
