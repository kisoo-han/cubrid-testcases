/*
Test Case: delete & delete
Priority: 1
Reference case: 
Author: Rong Xu

Test Point:
C1 delete some rows
 C2 delete one row included in C1's rows
 C2 rollback
C1 commit

NUM_CLIENTS = 2
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int primary key,col varchar(10)) partition by range(id)(partition p1 values less than (10000),partition p2 values less than MAXVALUE);
C1: insert into t select rownum,'a' from db_class limit 5;
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: delete from t where id>0 and 0=(select sleep (3));
MC: sleep 1;
C2: delete from t where id=3;
MC: wait until C1 blocked;
C2: rollback;
MC: wait until C2 ready;
MC: wait until C1 ready;
/* expect no value */
C1: select * from t order by 1,2;
C1: commit;
MC: wait until C1 ready;

/* expected  no value*/
C2: select * from t order by 1;
C2: commit;
MC: wait until C2 ready;

C2: quit;
C1: quit;

