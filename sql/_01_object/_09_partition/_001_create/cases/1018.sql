--List(have NULL value) partition creating test with int type and null value
create table list_test(id int,
			test_int int,
			test_smallint smallint,
			test_numeric numeric(38,10),
			test_float float,
			test_real real,
			test_double double,
			test_monetary monetary,
			test_datetime timestamp, primary key(id,test_int))
	PARTITION BY LIST (test_int) (
	PARTITION p0 VALUES IN (1,3,5,7,9,NULL)
);

select * from db_class where class_name like 'list%' order by 1;


drop table list_test;
