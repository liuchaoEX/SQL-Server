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
