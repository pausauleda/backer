#!/bin/bash
#
# script para crear copias incrementales con hardlinks
#
# el enlace $DIRBACKUPS/ultimo apunta a la última copia realizada, sobre la cual se crea la incremental
# si no existe este enlace, entiende que es la primera copia y crea la copia base
#
# los backups se realizan en $DIRBACKUPS
# los directorios a respaldar se leen del archivo backer.conf, en el mismo directorio del script
#


TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`

DIRBACKUPS=/backups
RUTAFICH=`/usr/bin/dirname $0`
FICHDIRS=$RUTAFICH/backer.conf

while read LINEA
do
	if [[ !($LINEA =~ ^#) ]] # si la linea no empieza por almohadilla
	then
	   DIRSACOPIAR="$DIRSACOPIAR $LINEA" # agrega la linea a la lista de directorios
	fi
done < $FICHDIRS


if [ ! -h $DIRBACKUPS/ultimo ]
then
   rsync -aP $DIRSACOPIAR $DIRBACKUPS/backup_$TIMESTAMP && ln -s $DIRBACKUPS/backup_$TIMESTAMP $DIRBACKUPS/ultimo
else
   rsync -aP --link-dest=$DIRBACKUPS/ultimo $DIRSACOPIAR $DIRBACKUPS/backup_$TIMESTAMP
   rm $DIRBACKUPS/ultimo
   ln -s $DIRBACKUPS/backup_$TIMESTAMP $DIRBACKUPS/ultimo
fi
