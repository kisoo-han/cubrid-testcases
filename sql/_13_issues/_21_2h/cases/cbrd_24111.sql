DROP TABLE IF EXISTS tb1, tb2; 
DROP view IF EXISTS v1;

CREATE TABLE tb1(a VARCHAR(1500),id INT AUTO_INCREMENT); 
CREATE TABLE tb2(a VARCHAR(1500),id INT AUTO_INCREMENT); 
insert into tb1 values(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(8,8),(8,8);
insert into tb2 values(7,7),(8,8),(9,9),(8,8),(8,8);
create view v1 as select aa.a from tb1 aa, tb2 bb where aa.a = bb.a;
set @newincr=0; 
select count(*) from v1 a, v1 b where (@newincr:=@newincr+1) <= 5;

DROP variable @newincr;
DROP TABLE IF EXISTS tb1, tb2;
DROP view IF EXISTS v1;
