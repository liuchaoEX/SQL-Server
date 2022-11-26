--14.2定义事务、回滚事务
begin tran
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','001',1,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','002',2,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','003',3,'报名')
select * from StuCou where StuNo='00000025'
rollback tran--回滚
select * from StuCou where stuno='00000025'
begin tran --事务开始
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','002',1,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','003',2,'报名')
commit tran--提交
select * from StuCou where StuNo='00000025'
go
begin tran
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','001',1,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','002',2,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','003',3,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','004',4,'报名')
insert into StuCou(StuNo,CouNo,WillOrder,State) values('00000025','005',5,'报名')
declare @countnum int
set @countnum=
(select count(*) from StuCou where StuNo='00000025')
if @countnum<=3
	begin
		commit tran
		print '你已成功选报课程'
	end
else
	begin
		rollback tran
		print '报名科目数不能超过3科'
	end
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
--多个事务串行化
--锁
--锁定资源类型
--RID key  pg ext tab  db
--锁模式
--共享锁（select）、排他式（update delete insert）、更新锁
