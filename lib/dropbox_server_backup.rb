require 'dropbox_sdk'
require 'term/ansicolor'
require 'dropbox_server_backup_app'

c = Term::ANSIColor

if ARGV[0] == "setup"
  
  settings_path = ARGV[1] || "/etc/dropbox_server_backup"
  
  print c.bold, c.on_yellow, "Setting up dropbox server backup utility...", c.clear, "\n"
  begin

    Dir.mkdir "/etc/dropbox_server_backup" unless File.exists?("#{settings_path}")
    puts "First create a Dropbox app here: https://www.dropbox.com/developers/apps"
    puts "and then click \"Enable additional users\""
    puts "Done? Hit ENTER and continue."
    $stdin.gets.chomp
    puts "Now, please insert your Dropbox APP_KEY and press ENTER:"
    app_key = $stdin.gets.chomp
    puts ""
    puts "and also your APP_SECRET:"
    app_secret = $stdin.gets.chomp
    app = DropboxServerBackupApp.create(:app_key => app_key, :app_secret => app_secret) do |auth_url|
      puts "Now please visit this URL and approve the app: #{auth_url}" 
      puts "Done? Hit ENTER and continue."
      $stdin.gets.chomp
    end
    
    puts "Settings written to #{settings_path}/credentials"
    if File.exists?("#{settings_path}/credentials")
      print "File #{settings_path}/credentials exists. Rewrite? (y/n): "
      rewrite_credentials_file = ($stdin.gets.chomp == "y")
    end
    File.open("#{settings_path}/credentials", "w") { |f| f.puts app.session.serialize } unless rewrite_credentials_file == false

    `touch #{settings_path}/filelist`
    puts "#{c.green}Please add paths of the files you want to be backed up to the #{c.white}#{settings_path}/filelist#{c.clear}#{c.green}\nSeparate each file path with a newline#{c.clear}."
    puts ""
    puts "#{c.green}Then run #{c.white}crontab -e#{c.green} and put the following in it: #{c.white}0 0 * * * dropbox_server_backup\n #{c.green}to run it every day at midnight.#{c.clear}"


  rescue Errno::EACCES
    print c.red, "ERROR: it looks like you don't have access to your /etc directory\nwhere dropbox_server_backup utility stores its settings.", "\n"
    print "Try running with ", c.bold, "sudo", c.clear, "\n"

  rescue DropboxAuthError
    print c.red, "ERROR: Dropbox authentication failed.", c.clear, "\n"
  end

else

  settings_path = ARGV[0] || "/etc/dropbox_server_backup"
  app           = DropboxServerBackupApp.new DropboxSession.deserialize(File.read("#{settings_path}/credentials"))
  files         = File.readlines("#{settings_path}/filelist").compact.uniq.map { |l| l.chomp }

  files.each { |f| app.upload(f) unless f.empty? }

end
