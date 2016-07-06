#!/bin/bash

USER=$(whoami)

while IFS='' read -r line || [[ -n "$line" ]]
do
	printf "Processing: $line\n"
	rsync -Ravhz --progress $line /$USER/Backup/ >> /dev/null
 
done < $1

cd $USER/Backup/$USER/

for dir in $USER/Backup/$USER/*
do
	base=Backup_$(basename "$dir")_$(date +%Y%m%d)
	printf "Processing: $dir\n"
	tar -czf $base.tar.gz "$dir" >> /dev/null
done

# Script usage
# backup.sh folderlist.txt
#
# usage:
# rsync -avh --progress --delete /source /destination
#
# Options
#
# -a: -a indicates archive mode. Is equivalent to rsync -rlptgoD. Include Recursive mode, Preserves symbolic links, Preserves permissions, Preserves timestamp, Preserves owner and group.
# -v: -v verbose
# -z: -z is to enable compression
# -r: -r indicates recursive
# -h: This option produces numbers in the log file and stdout in a more human-readable format.
# --delete: This tells rsync to delete any files that are in destination that aren’t in source. If you choose to use this option, I recommend also using the verbose options, for reasons mentioned above.
# --progress: This option tells rsync to print information showing the progress of the transfer.
# --exclude: --exclude option will cause files that match the given patterns to be excluded
# --stats: --stats shows a detailed stats of each backup. You can monitor the amount of traffic being sent over your network and such.
#
# Examples
#
# http://www.thegeekstuff.com/2010/09/rsync-command-examples/
# http://www.evbackup.com/support-commonly-used-rsync-arguments/
# http://www.howtogeek.com/135533/how-to-use-rsync-to-backup-your-data-on-linux/
# https://www.linux.com/learn/tutorials/836851-how-to-backup-files-in-linux-with-the-command-line
# https://wiki.archlinux.org/index.php/full_system_backup_with_rsync
# http://www.sanitarium.net/golug/rsync_backups_2010.html
# http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
#
# Compress
#
# Usage: 
# tar -cvfz backup_NAMEFOLDER_$(date +%Y%m%d).tar.gz /directory
#
# Options
#
# c: Creates a new tar archive
# v: Specifies that tar should be more verbose about the operations it is performing. This option can be specified multiple times for some operations to increase the amount of information displayed 
# f: tar will use the file archive as the tar archive it performs operations on
# z: This option tells tar to read or write archives through gzip, allowing tar to directly operate on several kinds of compressed archives transparently
#
# Examples
#
# http://www.tecmint.com/18-tar-command-examples-in-linux/
