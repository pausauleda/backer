#!/bin/bash
#
# script para crear copias incrementales con hardlinks
#
# el enlace $DIRBACKUPS/ultimo apunta a la última copia realizada, sobre la cual se crea la incremental
# si no existe este enlace, entiende que es la primera copia y crea la copia base

TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

DIRBACKUPS=/backups
DIRSACOPIAR="/etc /var/www"

if [ ! -h $DIRBACKUPS/ultimo ]
then
   rsync -aP $DIRSACOPIAR $DIRBACKUPS/backup_$TIMESTAMP && ln -s $DIRBACKUPS/backup_$TIMESTAMP $DIRBACKUPS/ultimo
else
   rsync -aP --link-dest=$DIRBACKUPS/ultimo $DIRSACOPIAR $DIRBACKUPS/backup_$TIMESTAMP
   rm $DIRBACKUPS/ultimo
   ln -s $DIRBACKUPS/backup_$TIMESTAMP $DIRBACKUPS/ultimo
fi
