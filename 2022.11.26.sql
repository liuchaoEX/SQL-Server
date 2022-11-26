--14.4事务嵌套：插入记录，分别放在3个事务中完成
create table testtran
(A int, B nvarchar (3))
go
begin transaction
insert into testtran values(1,'aaa')
begin transaction
insert into testtran values(2,'bbb')
begin transaction
insert into testtran values(3,'ccc')
commit transaction

delete from testtran
--14.5嵌套事务：不能撤销最内层商务
begin transaction t1
insert into testtran values(1,'aaa')
begin transaction t2
insert into testtran values(2,'bbb')
begin transaction t3
insert into testtran values(3,'ccc')
rollback transaction

select * from testtran

--并发、锁
--没有控制并发，产生的结果
--数据丢失或被覆盖、为确定的相关性、不一致分析、幻读
