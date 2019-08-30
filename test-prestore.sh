#!/bin/sh
#
# started by Matija Nalis <mnalis-git@voyager.hr> 2019-08-30 GPLv3+
# 
# test script to import files parsed by mysql_prestore
#

IMPORT_DIR=./tmp 
MYSQL_CMD="mysql"
#MYSQL_CMD="less"
MYSQL_CMD='egrep -i DROP\sVIEW|^CREATE'

if [ -z "$1" ]
then
	echo "Usage: $0 [number_of_parallel_processes]"
	exit 1
fi

MAX_CPU="$1"

if [ ! -e ${IMPORT_DIR}/mysql-prestore.tail ]
then
	echo "ERROR: mysql-prestore not yet finised (and this W.I.P. script requires it) or IMPORT_DIR=$IMPORT_DIR is wrong"
	exit 2
fi

echo "$0 Start at `date`"
sed -e 's/^-- PRESTORE_ONLY_ONCE: //' < ${IMPORT_DIR}/mysql-prestore.head | $MYSQL_CMD

#find $IMPORT_DIR -type f -iname "mysql-prestore.table*" |
#	sort -g |
#	egrep -v 'table000134|table000800' | 	# FIXME - delete, for test only
#	xargs -ri -P $MAX_CPU sh -c "cat ${IMPORT_DIR}/mysql-prestore.head {} | $MYSQL_CMD"

cat ${IMPORT_DIR}/mysql-prestore.head ${IMPORT_DIR}/mysql-prestore.tail | $MYSQL_CMD
echo "$0 End  at  `date`"
