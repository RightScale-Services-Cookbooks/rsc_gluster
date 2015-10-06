# rsc_gluster cookbook
This cookbook is designed to work with RightScale ServerTemplates using the v14 lineage.
It is based off the [gluster](https://github.com/RightScale-Services-Cookbooks/gluster).  See that
cookbook for details on providers and additional attributes for overrides.

# OS Support
* Ubuntu 14.04
* Centos 6.7

# Cookbooks
* gluster from git://github.com/RightScale-Services-Cookbooks/gluster.git
* rsc_remote_recipe from git://github.com/RightScale-Services-Cookbooks/rsc_remote_recipe.git
* marker from git://github.com/rightscale-cookbooks/marker.git
* machine_tag from git://github.com/rightscale-cookbooks/machine_tag.git
* rightscale_tag from git://github.com/rightscale-cookbooks/rightscale_tag.git
* rs-storage from git://github.com/rightscale-cookbooks/rs-storage.git

# Attributes
* `node['rsc_gluster']['brick']['path']` - 'The path for gluster to share out'

# Recipes
* rsc_gluster::default - needed for both client and server, sets up repos, etc.
* rsc_gluster::client - uses rightscale_tag to setup gluster client.
* rsc_gluster::server - sets up gluster::server and machine_tag(`gluster:server=true`)
* rsc_gluster::server-peer-probe - searches for tags and `peer probe`'s additional hosts
* rsc_gluster::volume - calls rs-storage::volume on all servers tagged with `gluster:server=true`
* rsc_gluster::setup-replica - creates a replica-set across all servers tagged with `gluster:server=true`
* rsc_gluster::fix-restored-party-attr - clears restored volume attributes that have been restored by `rsc_gluster::volume`

# Author
Author:: RightScale, Inc. (<ps@rightscale.com>)
