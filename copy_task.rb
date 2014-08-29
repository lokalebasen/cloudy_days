require_relative 'cloud_copier'

class CopyTask

  attr_reader :backup_folder_path, :fog

  def initialize(folder, fog)
    @backup_folder_path = folder
    @fog = fog
  end

  def download_changes
    CloudCopier.new(fog, absolute_backup_folder_path).download_changes
  end

  private

  def absolute_backup_folder_path
    if backup_folder_path.start_with?('/')
      backup_folder_path
    else
    # The folder is a relative path
      File.join(Dir.pwd, backup_folder_path)
    end
  end

end
