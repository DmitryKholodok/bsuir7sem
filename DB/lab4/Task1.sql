use AdventureWorks2012;

create table Person.PhoneNumberTypeHst (
	ID int identity(1,1) constraint PK_PhoneNumberTypeHst primary key,
	[Action] char(6),
	ModifiedDate datetime,
	SourceID int,
	UserName varchar(64),
	constraint FK_PhoneNumberTypeHst_PhoneNumberType foreign key (SourceID)
		references Person.PhoneNumberType (PhoneNumberTypeID)
		on delete set null
		on update cascade
)
GO

create trigger Person.PhoneNumberType_IUD
on Person.PhoneNumberType
after insert, update, delete
as
begin
	declare @action char(6), @date date, @user nvarchar(256)
	declare @sourceId int
	set @action = (
		case 
			when exists(select * from inserted) and exists(select * from deleted) then 'update'
			when exists(select * from inserted) then 'insert'
			when exists(select * from deleted) then 'delete'
		end
	)
	set @date = GETDATE()
	set @user = SUSER_NAME()

	if (@action = 'delete') 
		insert into Person.PhoneNumberTypeHst ([Action], ModifiedDate, SourceID, UserName)
		select @action, @date, null, @user from deleted
	else 
		insert into Person.PhoneNumberTypeHst ([Action], ModifiedDate, SourceID, UserName)
		select @action, @date, PhoneNumberTypeID, @user from inserted
	
end;
GO

----------------- virtual table = view
create view Person.vPhoneNumberType
with encryption
as
	select * from Person.PhoneNumberType
GO

select * from Person.vPhoneNumberType order by PhoneNumberTypeID desc;

SELECT OBJECT_DEFINITION(OBJECT_ID(N'Person.vPhoneNumberType'));

SET IDENTITY_INSERT Person.PhoneNumberType OFF

insert into Person.vPhoneNumberType (PhoneNumberTypeID, Name, ModifiedDate)
values (123123, 'insertedValue', GETDATE());

update Person.vPhoneNumberType
set Name = N'updatedValue'
where PhoneNumberTypeID = 123123;

delete from Person.vPhoneNumberType
where PhoneNumberTypeID = 123123;

select * from Person.PhoneNumberTypeHst;

drop table Person.PhoneNumberTypeHst;
drop view Person.vPhoneNumberType;
drop trigger Person.PhoneNumberType_IUD;