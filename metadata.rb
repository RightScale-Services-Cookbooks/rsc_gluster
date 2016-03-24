name             'rsc_gluster'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rsc_gluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'marker', '~> 1.0.1'
depends 'machine_tag', '~> 1.1.0'
depends 'ephemeral_lvm', '~> 1.0.12'
depends 'gluster'
depends 'rightscale_tag', '~> 1.1.0'
depends 'rsc_remote_recipe'
depends 'rs-storage', '~> 1.1.0'
depends 'rightscale_backup', '~> 1.2.0'

recipe 'rsc_gluster::default', 'verifies settings from gluster recipes'
recipe 'rsc_gluster::server', 'installs gluster server'
recipe 'rsc_gluster::server-peer-probe', 'gets peers from tag service'
recipe 'rsc_gluster::volume', 'calls rs-storage::volume on all servers'
recipe 'rsc_gluster::setup-replica', 'creates replica set'
recipe 'rsc_gluster::client', 'sets up gluster client from tags'
recipe 'rsc_gluster::fix-restored-party-attr', 'clears restored attributes'

attribute 'rsc_gluster/brick/path',
  :display_name => 'Gluster Brick Path',
  :description => 'Gluster Brick Path',
  :default => '/mnt/ephemeral',
  :required => 'recommended'
