--12.2��student����update��Ĵ���������ʾ�޸�ǰ�������
create trigger update_student_trigger
on student
for update
as
print '�޸�ǰ������'
select * from deleted
print '�޸ĺ������'
select * from inserted


--��֤������
update student set StuName='��С��' where stuname='�ֱ�'

select *from student
update student set pwd='1111111' where StuName='��С��'
go


--12.4�����������������ִ��ĳ�������ò����ᱻ�������
--��ֹ�Ա�ִ����ز�������ֹ��department��ִ�и��²���
create trigger update_department_trigger
on department
instead of update
as
print '��ֹ�Ա�ִ�и��²���'

--��֤
select * from department

update department set DepartName='Ӣ��ϵ' where DepartNo='03'
--�޸�

go
alter trigger update_department_trigger
on department
instead of update,insert
as
print '��ֹ�Ա�ִ�и��²���'
--��֤
go
insert into Department values('04','����ϵ')
--12.5  stucou��course;  ����stucou���е����ݽ��и���ʱ��(ѡ������ı䶯)��course���е���������Ӧ�仯
--��stucou�в�ѯѡ��001�γ̵�����
select count(*) from StuCou where CouNo='001'
go

create trigger setwillnum
on stucou
after insert,delete,update
as
update course set willnum=willnum+1