require_relative 'directory_updater'

class CloudCopier

  attr_reader :fog, :ignored_directories, :backup_folder_path
  def initialize(fog, backup_folder_path)
    @backup_folder_path = backup_folder_path
    @fog = fog
    @ignored_directories = []
  end

  def download_changes
    fog.directories.each do |directory|
      if ignored_directories.include? directory.key
        puts "Ignoring #{directory.key}."
      else
        puts "Synchronizing #{directory.key}..."
        sync_dir(directory)
      end
    end
  end

  private

  def ensure_backup_folder_exists
    FileUtils.mkdir_p(backup_folder_path)
  end

  def ignore(*keys)
    @ignored_directories += keys.flatten.map(&:to_s)
  end

  def sync_dir(directory)
    DirectoryUpdater.new(backup_folder_path, directory).update
  end

end
