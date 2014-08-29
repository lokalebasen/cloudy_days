require_relative 'file_updater'

class DirectoryUpdater

  attr_reader :backup_folder_path, :cloud_directory

  def initialize(backup_folder_path, cloud_directory)
    @backup_folder_path = backup_folder_path
    @cloud_directory = cloud_directory
  end

  def update
    cloud_directory.files.each do |file|
      FileUpdater.new(file_path(file.key), file).update
    end
  end

  def file_path(relative_filename)
    File.join(backup_folder_path, cloud_directory.key, relative_filename)
  end

end
