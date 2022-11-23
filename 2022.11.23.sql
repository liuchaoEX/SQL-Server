--12.2对student创建update后的触发器，显示修改前后的数据
create trigger update_student_trigger
on student
for update
as
print '修改前的数据'
select * from deleted
print '修改后的数据'
select * from inserted
--验证触发器
update student set StuName='林小斌' where stuname='林斌'

select *from student
update student set pwd='1111111' where StuName='林小斌'
go

--12.4创建替代触发器：当执行某操作，该操作会被触发替代
--禁止对表执行相关操作，禁止对department表执行更新操作
create trigger update_department_trigger
on department
instead of update
as
print '禁止对表执行更新操作'

--验证
select * from department
update department set DepartName='英语系' where DepartNo='03'
--修改
go
alter trigger update_department_trigger
on department
instead of update,insert
as
print '禁止对表执行更新操作'
--验证
go
insert into Department values('04','旅游系')
--12.5  stucou和course;  当对stucou表中的数据进行更新时，(选课情况的变动)，course表中的人数做相应变化
--在stucou中查询选修001课程的人数
select count(*) from StuCou where CouNo='001'
go

create trigger setwillnum
on stucou
after insert,delete,update
as
update course set willnum=willnum+1 where couno=(select couno from inserted)
update course set willnum=willnum-1 where couno=(select couno from deleted)
print 'course表的人数已做相应更新'

--验证
select * from stucou where couno='018'
delete stucou where couno='018' and stuno='010000001'
select * from course where couno='019' or couno='018'
--000000001   018  ->019
update StuCou set couno='019' where couno='018' and stuno='00000001'

select * from stucou
--12.6针对某个列进行修改时
update Department set DepartNo='05' where DepartName='管理系'
go
--12.7继续在department上创建update触发器
create trigger text_trigger
on department
for update
as
print '二次触发'
update Department set DepartName='计算机系' where DepartNo='05' 
--删除触发器
drop trigger text_trigger
--重命名
sp_rename text_trigger ,test_trg
--禁用触发器
alter table Department disable trigger test_trg
update Department set DepartName='管理系' where DepartNo='05'
--启动触发器
alter table department enable trigger test_trg
update Department set DepartName='计算机系' where DepartNo='05'
--操作数据全部执行，delete  update
--update  score   set  cj=cj+10  where  cj<60
/*
游标的处理过程：
	Declare创建游标
	Open打开游标
	Fetch取游标一行，要循环处理
	Close关闭游标
	Deallocate 删除游标
*/
--创建游标的格式
--declare  游标名称  cursor  游标类型 

--创建游标，通过游标逐条读取course表中每条记录
declare cur_course cursor forward_only
for
select * from Course

--打开游标
open cur_course
--读取数据
fetch next from cur_course
fetch next from cur_course
fetch next from cur_course
--通过游标更新当前游标指向的数据
update course set limitnum=100 where current of cur_course
fetch next from cur_course
update course set limitnum=200 where current of cur_course
--通过游标删除当前游标指向的数据
delete from course where current of cur_course
--关闭游标
close cur_course
--释放(删除)游标
deallocate cur_course
go

--13.2 创建使用变量的游标：创建游标将course表中的couno和couname存储到变量中
declare @couno char(3),@couname char(30)
declare crscourse cursor
for
select couno,couname from course order by couno
open crscourse
fetch next from crscourse into @couno,@couname
while @@fetch_status=0
begin
print '课程编号'+@couno+'课程名称:'+@couname
print ('-----------------------------------')
fetch next from crscourse into @couno,@couname
end

deallocate crscourse
select @@fetch_status
