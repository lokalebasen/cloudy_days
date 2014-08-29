class FileUpdater

  attr_reader :path, :cloud_file

  def initialize(absolute_path, cloud_file)
    @path = absolute_path
    @cloud_file = cloud_file
  end

  def update
    if local_file_exists?
      if local_file_is_outdated?
        update_file
      else
        puts "#{path} is already in sync."
      end
    else
      create_file
    end
  end

  private

  def local_file_exists?
    File.exists?(path)
  end

  def local_file_is_outdated?
    timestamp_has_changed? || length_has_changed?
  end

  def timestamp_has_changed?
    local_time = File.mtime(path)
    remote_time = cloud_file.last_modified.to_time
    remote_time > local_time
  end

  def length_has_changed?
    remote_file_size != local_file_size
  end

  def remotely_modified
    cloud_file.last_modified.to_time
  end

  def locally_modified
    File.mtime(path)
  end

  def remote_file_size
    cloud_file.content_length
  end

  def local_file_size
    File.size?(path)
  end

  def update_file
    puts "Writing #{path}"
    File.open(path, 'w') do |local_file|
      local_file.write(cloud_file.body)
    end
  end

  def create_file
    ensure_directory_for_local_file
    update_file
  end

  def ensure_directory_for_local_file
    FileUtils.mkdir_p(File.dirname(path))
  end

end