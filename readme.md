### cloudy_days

cloudy_days is a ruby script for backing up all cloudfiles containers on your Rackspace cloudfiles account.

The first time you run it, it will download everything. On subsequent runs it will only download new/changed files.

Running it works through rake. Here goes:

    bundle install
    bundle exec rake sync[rackspace.username,rackspace.api_key,optional_backup_destination,a\|pipe\|delimited\|list\|of\|containers\|to\|skip]

Third and fourth argument, backup_destination and the list are optional. If you omit backup_destination, cloudy_days will create a backup folder in this script's where it will save the backup.

The backup_path can be a relative path my/nice/backups or an absolutely path /home/foobar/backups/cloudfiles

Enjoy. :-)
