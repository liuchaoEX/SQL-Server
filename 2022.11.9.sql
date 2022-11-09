--9.2 内置函数
--字符函数
select ascii('a'),char(100)
select right('abcds',2),left('abcds',2),substring('abcdfe',2,3)
select len(ltrim('  djkk  ')),len(rtrim('  jki  '))
select len('  kjk  ')
select lower('Abcd'),upper('BCdf')
select reverse('abcd')
select charindex('ab','nklabcdf')
select replicate('av',3)
--日期函数
select getdate()
select datename(year,getdate())
select datename(dy,getdate())
select datename(week,getdate())
select datename(dw,getdate())
select datepart(dw,getdate())
select datepart(dy,getdate())
select datepart(year,getdate())
--select datediff(日期元素，日期1，日期2)
select datediff(year,'2000/10/10','2020/10/10')
select datediff(dw,'2000/10/10','2020/10/10')
select datediff(dd,'2002/12/16',getdate())
select dateadd(dd,10,getdate())
select year(getdate())
--数学函数
select abs(-34),ceiling(3.4),floor(3.4),pi(),power(3,4),rand(),round(123.3456,2),sqrt(18)
--系统函数
select cast(1234 as char(4))
select len(1234)
select len('1234')
select '123'+123
select convert(char(5),1234)
select host_name()
select isdate('2020/2/30')
select isnumeric('2020/2/30')
select datalength('345地方')
select len('345地方')
--元数据函数
select COL_LENGTH('student','stuno')
select col_name(object_id('student'),3)
select db_id('xk')
--安全函数
select user
select has_dbaccess('xk')
--配置函数
--自定义函数
create function 函数名(函数参数)
returns table
as
begin
 return select 语句
end
--自定义函数完成任意两个数的求和
--标量值函数：只返回一个结果的函数
go
create function qh(@x float,@y float)
returns float
as
begin
 return @x+@y
 end
 go

 select dbo.qh(3.8987,56789)

 --封装一个函数完成阶乘的功能
 go
 create function jc(@x int)
 returns int
 as
 begin
  declare @i int,@k int
  select @i=1,@k=1
  while @i<=@x
   begin
    set @k=@k*@i
 set @i=@i+1
   end
 return @k
 end
 go

 select dbo.jc(18)
 --表值函数：返回值是表中的内容，可以是任意多列
 --select：select命令正确，镶嵌到函数结构中
 --查询林斌所选的课程，及相应的上课老师和上课时间
 select couname,teacher,schooltime
 from course join student on course.CouNo=stucou.CouNo
 join student on Student.StuNo=stucou.StuNo
 where stuname=@name
 --表值函数的语法
 /*create function 函数名(函数参数)
returns table
as
begin
 return select 语句
end
*/
go
create function cxl(@name char(10))
returns table
as
return
select couname,teacher,SchoolTime
from course join stucou on course.CouNo=stucou.CouNo
join student on Student.StuNo=stucou.StuNo
where stuname=@name
go
select * from dbo.cxl('梁亮')

--计算机应用工程系开设的课程选修情况（课程名，选修人数，上课老师）
create function cx2(@xb char(20))
returns table
as
return
select couname,willnum,teacher
from Course join Department on Course.DepartNo=Department.DepartNo
where DepartName=@xb
go

select * from dbo.cx2('建筑工程系')
