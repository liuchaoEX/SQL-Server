--9.2 ���ú���
--�ַ�����
select ascii('a'),char(100)
select right('abcds',2),left('abcds',2),substring('abcdfe',2,3)
select len(ltrim('  djkk  ')),len(rtrim('  jki  '))
select len('  kjk  ')
select lower('Abcd'),upper('BCdf')
select reverse('abcd')
select charindex('ab','nklabcdf')
select replicate('av',3)
--���ں���
select getdate()
select datename(year,getdate())
select datename(dy,getdate())
select datename(week,getdate())
select datename(dw,getdate())
select datepart(dw,getdate())
select datepart(dy,getdate())
select datepart(year,getdate())
--select datediff(����Ԫ�أ�����1������2)
select datediff(year,'2000/10/10','2020/10/10')
select datediff(dw,'2000/10/10','2020/10/10')
select datediff(dd,'2002/12/16',getdate())
select dateadd(dd,10,getdate())
select year(getdate())
--��ѧ����
select abs(-34),ceiling(3.4),floor(3.4),pi(),power(3,4),rand(),round(123.3456,2),sqrt(18)
--ϵͳ����
select cast(1234 as char(4))
select len(1234)
select len('1234')
select '123'+123
select convert(char(5),1234)
select host_name()
select isdate('2020/2/30')
select isnumeric('2020/2/30')
select datalength('345�ط�')
select len('345�ط�')
--Ԫ���ݺ���
select COL_LENGTH('student','stuno')
select col_name(object_id('student'),3)
select db_id('xk')
--��ȫ����
select user
select has_dbaccess('xk')
--���ú���
--�Զ��庯��
create function ������(��������)
returns table
as
begin
 return select ���
end
--�Զ��庯��������������������
--����ֵ������ֻ����һ������ĺ���
go
create function qh(@x float,@y float)
returns float
as
begin
 return @x+@y
 end
 go

 select dbo.qh(3.8987,56789)

 --��װһ��������ɽ׳˵Ĺ���
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
 --��ֵ����������ֵ�Ǳ��е����ݣ��������������
 --select��select������ȷ����Ƕ�������ṹ��
 --��ѯ�ֱ���ѡ�Ŀγ̣�����Ӧ���Ͽ���ʦ���Ͽ�ʱ��
 select couname,teacher,schooltime
 from course join student on course.CouNo=stucou.CouNo
 join student on Student.StuNo=stucou.StuNo
 where stuname=@name
 --��ֵ�������﷨
 /*create function ������(��������)
returns table
as
begin
 return select ���
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
select * from dbo.cxl('����')

--�����Ӧ�ù���ϵ����Ŀγ�ѡ��������γ�����ѡ���������Ͽ���ʦ��
