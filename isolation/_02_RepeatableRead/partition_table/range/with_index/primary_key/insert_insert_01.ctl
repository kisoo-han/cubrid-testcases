/*
Test Case: insert & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
two clients insert the same primary key column at the same time, the first rollback
partition id and primary key on different column

NUM_CLIENTS = 2
C1: insert(1,'abc');
C2: insert(11,'abc');
C1: rollback
C2: commit -- 1 row insert
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int,col varchar(10), primary key(id,col)) partition by range(id)(partition p1 values less than (10),partition p2 values less than (100));
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: insert into t values(1,'abc');
MC: wait until C1 ready;
C2: insert into t values(1,'abc');
MC: wait until C2 blocked;

/* expect (1,'abc') */
C1: select * from t order by 1;
C1: rollback work;
MC: wait until C1 ready;

MC: wait until C2 ready;
/* expect (11,'abc')*/
C2: select * from t order by 1;
C2: commit work;
MC: wait until C2 ready;

/* expect (11,'abc')*/
C1: select * from t order by 1;
C1: commit;
MC: wait until C1 ready;

C2: quit;
C1: quit;

