use AdventureWorks2012;
Go
------------------
create view Person.vCombined 
with encryption, SCHEMABINDING
as
	select pp.BusinessEntityID, pp.PhoneNumber, pp.PhoneNumberTypeID, pp.ModifiedDate as ppModifiedDate, pnt.Name, pnt.ModifiedDate as pntModifiedDate
	from Person.PhoneNumberType pnt
	join Person.PersonPhone pp on pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID
GO

create unique clustered index IDX_vCombined 
	on Person.vCombined (BusinessEntityID, PhoneNumberTypeID)
GO
 
select * from Person.vCombined
go

drop view Person.vCombined;

----

create trigger Person.vCombined_IO
on Person.vCombined
instead of insert, update, delete as
begin
	declare @action char(6)
	set @action = (
		case 
			when exists(select * from inserted) and exists(select * from deleted) then 'update'
			when exists(select * from inserted) then 'insert'
			when exists(select * from deleted) then 'delete'
		end
	)

	if (@action = 'delete') 
		delete 
			pp 
		from 
			Person.PersonPhone pp
			join deleted d on pp.BusinessEntityID = d.BusinessEntityID;
	else if (@action = 'insert')
		begin
			if exists (select 1 from Person.PhoneNumberType pnt where pnt.PhoneNumberTypeID in (select PhoneNumberTypeID from inserted))
				update 
					Person.PhoneNumberType
				set 
					PhoneNumberType.Name = i.Name,
					PhoneNumberType.ModifiedDate = i.pntModifiedDate
				from 
					Person.PhoneNumberType pnt
				inner join 
					inserted i 
				on 
					pnt.PhoneNumberTypeID = i.PhoneNumberTypeID
			else
				insert into Person.PhoneNumberType (PhoneNumberTypeID, Name, ModifiedDate)
					select 
						i.PhoneNumberTypeID, 
						i.Name, 
						i.pntModifiedDate 
					from 
						inserted i; 

			insert into Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ModifiedDate)
				select 
					BusinessEntityID, 
					PhoneNumber, 
					PhoneNumberTypeID, 
					ppModifiedDate 
				from 
					inserted;	
		end;
	else 
		begin
			update 
				Person.PhoneNumberType 
			set 
				PhoneNumberType.Name = i.Name,
				PhoneNumberType.ModifiedDate = i.pntModifiedDate
			from 
				Person.PhoneNumberType pnt
			inner join 
				inserted i 
			on 
				pnt.PhoneNumberTypeID = i.PhoneNumberTypeID

			update Person.PersonPhone 
			set 
				PhoneNumber = i.PhoneNumber,
				ModifiedDate = i.ppModifiedDate
			from 
				Person.PersonPhone pp
			inner join
				inserted i
			on
				pp.PhoneNumberTypeID = i.PhoneNumberTypeID and 
				pp.BusinessEntityID = i.BusinessEntityID and
				pp.PhoneNumber = i.PhoneNumber
		end;
end;

drop trigger Person.vCombined_IO;


--------------------

SET IDENTITY_INSERT Person.PhoneNumberType OFF

insert into Person.vCombined (BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ppModifiedDate, pnt.Name, pntModifiedDate)
	select 3, '123-123-12345', 2, GETDATE(), 'NewName1', GETDATE() union all
	select 4, '123-123-12345', 2, GETDATE(), 'NewName1', GETDATE()

update 
	Person.vCombined
set 
	Name = N'UpdatedName_2'
where 
	BusinessEntityID = 3 and 
	PhoneNumberTypeID = 2;

delete 
from 
	Person.vCombined
where 
	BusinessEntityID = 3 and 
	PhoneNumberTypeID = 2;

select * from Sales.vCombined;