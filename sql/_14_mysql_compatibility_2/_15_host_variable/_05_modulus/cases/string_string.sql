--- mod (string , string)
create table t1 (s1 varchar(10), s2 char(10));

insert into t1 values ('2001-10-11','2');
insert into t1 values ('4','2');
select s1,s2, mod(s1,s2) from t1 order by 1,2,3;

truncate table t1;

-- col / HV
insert into t1 values ('2001-10-11','2');
insert into t1 values ('4','2');
insert into t1 values ('4','0');

prepare st from 'select s1,s2, mod (s1 , ?) from t1 order by 1,2';
execute st using '2001-10-11';

prepare st from 'select s1,s2, mod (? , s2) from t1 order by 1,2';
execute st using '2';

prepare st from 'select s1,s2, mod (? , s2) from t1 order by 1,2';
execute st using NULL;

drop table t1;


-- 2HV
prepare st from 'select mod (? , ?)';
execute st using '2001-10-11','2';

prepare st from 'select mod (? , ?)';
execute st using '4','2';

prepare st from 'select mod (? , ?)';
execute st using '4','0';

prepare st from 'select mod (? , ?)';
execute st using '4','a';

prepare st from 'select mod (? , ?)';
execute st using '4',NULL;

prepare st from 'select mod (? , ?)';
execute st using NULL,'2';

-- 1 HV

prepare st from 'select mod (''4'' , ?)';
execute st using '2';

prepare st from 'select mod (''4'' , ?)';
execute st using n'2';

