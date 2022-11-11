--变量
--局部变量(声明，变量赋值，变量的显示)
--声明：declare  @变量名  变量类型……
declare @name char(10),@cj float ,@csrq datetime
--赋值：set  select
--set  只能赋值一个变量
--select 可以赋值多个变量
set @name='abc'
select @cj=89.5,@csrq='2000/10/12'
--把学号为00000007的姓名赋值给@name
select stuname from Student where StuNo='00000008'
set @name=(
select stuname from Student where StuNo='00000007')
select @name=stuname from Student where StuNo='00000007'
--显示
--print:只能一个对象
--select:可显示多个对象
print @name
select @cj+10.5 as 成绩,@csrq 出生日期,'年份'=year(@csrq)

--全局变量
select @@SERVERNAME
select stuname from Student where ClassNo='20000001'
select @@ROWCOUNT
select @@ERROR
go

declare @name char(10),@cj float ,@csrq datetime
set @name='abc'
select '姓名'+@name
--批处理
go
create view stuname
as
select stuname from Student
go
--视图的使用
select * from stuname
use Xk
go
create view stuno
as
select stuname from Student
go

declare @stuno char(10)
set @stuno='0001'
go
--流程控制语句
--if、begin  end、while、return、case、print
--任务9.1
--9.2：50与60之和
--9.3：显示course表中有多少类课程
--结果用变量显示

select * from Course
go
select couname,kind as '课程类型',
case kind
	when '信息技术' then '信息类课程'
	when '工程技术' then '工程类课程'
	when '人文' then '人文类课程'
	else '其他类型课程'
end as '课程类别'
from Course
order by 课程类别

--按每个课程的开设院系显示课程名，同时显示开设的院系。
--如01系显示计算机应用工程系，02则显示建筑工程系，03显示旅游系

select couname,departno as '系别号',
case departno
	when '01' then '计算机应用工程系'
	when '02' then '建筑工程系'
	when '03' then '旅游系'
end as '其他系'
from Course

--查询某一课程的报名人数
--输入课程名后，先判断是否存在课程
--存在：查询它的报名人数，继续判断报名人数，如50以上，显示爆满；如果30以下，显示稀少；30-50之间显示正常。
--不存在：显示输入课程无效

declare @couname char(20),@willnum int
set @couname='智能建筑'
if not exists
	(select * from Course where couname=@couname)
print '课程名输入有误，请重新输入'
else
	begin
		select @willnum=willnum from Course where CouName=@couname
		if @willnum>=50
		print '爆满！'+rtrim(@couname)+'的报名人数是'+convert(char(2),@willnum)
		else if @willnum between 30 and 50
		print '正常！'+rtrim(@couname)+'的报名人数是'+convert(char(2),@willnum)
		else if @willnum<30
		print '稀少！'+rtrim(@couname)+'的报名人数是'+convert(char(2),@willnum)
	end