class DropboxServerBackupApp

  attr_reader :session

  def initialize(session)
    @access_type = :app_folder
    @session     = session
    @client      = DropboxClient.new(session, @access_type)
  end

  def self.create(options)
    session = DropboxSession.new(options[:app_key], options[:app_secret])
    session.get_request_token
    yield(session.get_authorize_url)
    session.get_access_token
    self.new(session)
  end

  def upload(filename)
    dropbox_filename = File.basename(filename)
    begin
      metadata = @client.metadata(dropbox_filename)
      unless metadata[:is_deleted]
        log "deleting existing file #{dropbox_filename} from Dropbox"
        @client.file_delete(dropbox_filename)
      end
    rescue DropboxError
    end

    begin
      @client.put_file(dropbox_filename, open(filename))
      log "uploading file #{filename} from Dropbox"
    rescue DropboxAuthError
      log("can't authenticate with dropbox.", :error)
    rescue Errno::ENOENT 
      log("file #{filename} doesn't exist.", :error)
    rescue Errno::EACCES
      log("no access to file #{filename}.", :error)
    end
  end

  # TODO: make this method write actual logs to some file.
  # We'd have to create a log file in the directory defined during the setup process.
  # Because log dirs may differ on different systems, it would be nice to have some default
  # dir hardcoded and then allow to set it using a flag, like that:
  #
  #   dropbox_server_backup setup --log-dir=/var/log
  def log(message, error=false)
    full_message = ""
    full_message += "ERROR: " if error
    full_message += message
    puts full_message
  end

end
