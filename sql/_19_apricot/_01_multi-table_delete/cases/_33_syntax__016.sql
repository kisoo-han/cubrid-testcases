--CLIENT
create class t_tr(i int, tbl varchar(255));

create class t1(i int);
create trigger tr1 before delete on t1 execute insert into t_tr values(obj.i, 't1');
insert into t1 values (1), (2), (3), (4), (5);

create class t2(i int);
create trigger tr2 before delete on t2 execute insert into t_tr values(obj.i, 't2');
insert into t2 values (3), (4), (5), (6), (7);

delete t2 from t1 left join t2 on t1.i=t2.i;
select * from t1 order by 1;
select * from t2 order by 1;
select * from t_tr order by 1, 2;

drop class t1;
drop class t2;
drop class t_tr;