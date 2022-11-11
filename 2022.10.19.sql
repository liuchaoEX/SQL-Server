--select 字段  from  表名  where  条件   group  by  分组  order  by  排序
--2.19
select '课程类别'=Kind,count(*) from Course group by Kind
--2.20
select '课程类别'=Kind,count(*) from Course group by Kind with cube
--2.21
select kind,'人数最少'=min(WillNum),'人数最多'=max(WillNum)
from Course where WillNum>15 group by Kind
--2.22
select kind,'平均人数'=avg(WillNum)
from Course
where willnum>15
group by Kind
having avg(WillNum)>30
order by 平均人数
--2.23
select Kind,avg(willnum)
from Course
where kind in('信息技术','管理')
group by all kind

--思考：统计每个系别的选修学生数之和，并按人数多少升序排序
select DepartNo,sum(willnum)
from Course
group by DepartNo
order by sum(WillNum)

--2.24
select * from Course where WillNum>
(select avg(willnum) from Course)
--2.25
select couname from Course where CouNo in
(select CouNo from StuCou where State='报名')
--2.26
select stuname from Student where StuNo in
(select distinct stuno from StuCou where State='报名')
select stuno,stuname from Student where exists
(select StuNo from StuCou where state='报名' and StuNo=Student.stuno)

--思考：查询计算机应用工程系开设的选修课程

select couname from Course where DepartNo=
(select DepartNo from Department where DepartName='计算机应用工程系')
--2.5节
--2.27
select ROW_NUMBER() over (order by willnum) as 'row_NUMBER',* from Course
select rank() over (order by willnum)as 'row_NUMBER',* from Course
select DENSE_RANK() over (order by willnum)as 'row_NUMBER',* from Course

--2.6
--2.28
select * from Student --m行
select * from class  --n行
select * from Student cross join class   --m*n行，m+n列

--2.29
select * from Student join class on Student.ClassNo=class.ClassNo
--2.30
select Student.*,departno,classname from Student join class on student.ClassNo=class.ClassNo

--2.31
select Student.StuNo,StuName,Course.Couno,Couname,WillOrder
from Student join StuCou on Student.StuNo=StuCou.StuNo
join Course on Course.CouNo=StuCou.CouNo
order by Student.StuNo,WillOrder

--2.32

select StuName,Couname,teacher
from Student join StuCou on Student.StuNo=StuCou.StuNo
join Course on Course.CouNo=StuCou.CouNo
join Department on Department.DepartNo=Course.DepartNo
where DepartName='计算机应用工程系'
order by StuName
