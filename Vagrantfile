VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'ducktrap-dev'
  config.vm.synced_folder '.', '/ducktrap'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = '.'
    puppet.manifest_file = 'development.pp'
  end
end