require 'fog'
require_relative 'copy_task'

STDOUT.sync = true

# eg Fog::Storage.new(provider: 'Rackspace', rackspace_api_key: "7754dd1c0bf441feb3d8c8e6b01f1a5f", rackspace_username: 'niels.buus', rackspace_region: :lon)

desc 'Updates/creates a local copy of all the cloudfiles on your rackspace account'
task :sync, :username, :api_key, :backup_folder do |t, rake_args|
  args = rake_args.to_hash

  backup_folder = args.fetch(:backup_folder, 'backup')
  username = args.fetch(:username)
  api_key = args.fetch(:api_key)

  fog_storage = Fog::Storage.new(provider: 'Rackspace', rackspace_api_key: api_key, rackspace_username: username, rackspace_region: :lon)

  CopyTask.new(backup_folder, fog_storage).download_changes
end