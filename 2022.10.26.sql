--统计各部门的班级数，要求显示部门名称和班级数量
select * from class
select * from department
select DepartName,count(*) as '班级数量'
from class join Department on class.DepartNo=Department.DepartNo
group by DepartName order by 班级数量

--查看“甘蕾”选修的课程名、学分、上课时间、志愿号，并按志愿号升序输出

--class student course  志愿号 (stucou,willorder)

select CouName,Credit,SchoolTime,WillOrder
from Student join StuCou on StuCou.StuNo=Student.StuNo
join Course on Course.CouNo=StuCou.CouNo
where stuname='甘蕾' order by WillOrder

select stuno from Student where StuName='甘蕾'
select stuno from StuCou where stuno='00000006'
--查看在‘周二晚’上课的课程名称和教师
select couname,teacher from Course
where SchoolTime='周二晚'

--统计‘01’年纪共有多少班
select '班级数'=count(*)from class where ClassName like '01%'
--统计各年级的班级数
select * from class
select left(classname,2) as 年级,'班级数'=count(*) from class
group by left(classname,2)

--查询的结果长期保存into

select left(classname,2) as 年级,'班级数'=count(*) 
into 班级数 
from class
group by left(classname,2)

--单元1：概述（SSMS和分离与附加）
--单元2：查询（select）
--单元3：数据管理（insert  update  delete  select）
--单元4：数据库设计（E-R图和关系模型）
--单元5：数据库（create alter drop sp_rename）
--单元6：表（create alter  drop）
--单元7：约束（primary，foreign，unique，check，default）
--单元8：索引
--索引的作用、索引的分类、如何使用索引
--创建索引：
select * into xs from Student
create unique nonclustered
index ix_stunocouno
on stucou(stuno,couno)

create
index ix_stuno
on stucou(stuno)


create unique nonclustered
index ix_stunocouno2
on stucou(couno,stuno)

drop index StuCou.ix_stuno

create index ix_stuno
on Student(stuno)

sp_helpindex stucou
go
sp_rename 'stucou.ix_stunocouno','ixnew_stuno'
go
--为class表建立基于classno的聚集索引pk_class,
--为class表建立基于classname的唯一、非聚集索引ix_class，
select * into newclass from class
create clustered index pk_class on newclass (classno)
create unique nonclustered index ix_class on newclass(classname)

--分析索引
set showplan_all on
go

select * from newclass where ClassNo='2000001'
go
set showplan_all off