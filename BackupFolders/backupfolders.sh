#!/bin/bash

clear

USER=$(whoami)

printf '%s\n' 'Copying files'
printf '%s\n' '-------------'

while IFS='' read -r line || [[ -n "$line" ]]
do
	printf '%s\n' "-Processing: $line"
	rsync -Ravhz --progress $line /home/$USER/Backup/ >> /dev/null
 
done < $1

cd /home/$USER/Backup/

printf '\n'
printf '%s\n' 'Compressing files'
printf '%s\n' '-----------------'

for dir in /home/$USER/Backup/home/$USER/*
do
	base=Backup_$(basename "$dir")_$(date +%Y%m%d)
	printf '%s\n' '-Compressing: '${dir##*/}
	tar -C /home/$USER/Backup/home/$USER/ -czf $base.tar.gz ${dir##*/} >> /dev/null
	echo $dir ' -> ' $base.tar.gz >> folders.txt
done

printf '\n'
printf '%s\n' 'Deleting files.....'
printf '\n'

rm -R /home/$USER/Backup/home/

# Script usage
# ./backupfolders.sh folderlist.txt
# folderlist.txt will contain all the absolute paths of what do you want to backup
# The compressed files will be on /home/$USER/Backup/


