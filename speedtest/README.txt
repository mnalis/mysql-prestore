machine:
	Dell PowerEdge R710
	24 x Intel(R) Xeon(R) CPU           X5670  @ 2.93GHz
	189 GB RAM
	DELL  PERC H700  2.10; with 1.8 TB SSD used for /var/lib/mysql and /var/log/mysql
	

mysql:
	Debian Jessie 8.11; mysql-server-5.5                 5.5.62-0+deb8u1

	innodb_data_file_path   = ibdata1:3000M;ibdata2:10M:autoextend
	innodb_log_file_size    = 1G
	key_buffer_size         = 128M
	innodb_buffer_pool_size 		= 2G
	innodb_buffer_pool_instances            = 2

	max_allowed_packet      = 512M
	# /tpaulic/ 20141201 hmm check http://www.percona.com/blog/2007/08/18/how-fast-can-you-sort-data-with-mysql/
	sort_buffer_size        = 8M
	myisam_sort_buffer_size = 8M
	# /tpaulic/ 20141201 hmm check http://www.percona.com/blog/2007/09/17/mysql-what-read_buffer_size-value-is-optimal/
	# and http://www.percona.com/blog/2006/06/06/are-larger-buffers-always-better/
	read_buffer_size        = 2M
	read_rnd_buffer_size    = 2M
	join_buffer_size        = 20M
	max_heap_table_size     = 20M
	tmp_table_size          = 20M
	# /tpaulic/ 20141201 hmm check http://www.percona.com/blog/2009/11/16/table_cache-negative-scalability/
	open_files_limit        = 60000
	table_open_cache        = 20000
	table_definition_cache  = 50000

	low_priority_updates = 1
	bulk_insert_buffer_size = 128M

	innodb_thread_concurrency       = 0
	#innodb_concurrency_tickets     = 1000
	thread_cache_size               = 55
	thread_stack                    = 256K
	query_cache_type=0
	query_cache_size=0
	innodb_log_buffer_size                  = 128M
	innodb_flush_log_at_trx_commit          = 1
	innodb_lock_wait_timeout                = 50
	innodb_open_files                       = 10000
	innodb_file_per_table                   = 1
	#innodb-flush-method                    = O_DIRECT
	innodb-log-files-in-group               = 2
	# see http://dba.stackexchange.com/questions/46752/mysql-5-5-high-cpu-usage
	innodb_file_format                      = BARRACUDA
	innodb_read_io_threads                  = 32
	innodb_write_io_threads                 = 32


test file:
	real production database backup
	957 tables with 133 million rows in them.
	5650561263 bytes (5.26 GB) mysql_repl_2019_07_01_01_17.sql.gz compressed - 57952403512 bytes (53.97 GB) uncompressed
	mysqldump --tab format: 38GB, tar.gz 3.1 GB
	61.3 GB mysqld DB on disk (+fixed 3 GB ibdata + 2*1 GB ib_logfile*) = 66.3 GB (tar.gz 8.7 GB)
	