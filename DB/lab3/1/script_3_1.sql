use AdventureWorks2012;

ALTER TABLE dbo.Person ADD EmailAddress NVARCHAR(50);

DECLARE @tableVar table (
	BusinessEntityId int not null,
	PersonType nchar(2) not null,
	NameStyle dbo.NameStyle,
	Title nvarchar(8),
	FirstName dbo.Name not null,
	MiddleName dbo.Name,
	LastName dbo.Name not null,
	Suffix nvarchar(10),
	EmailPromotion int not null,
	EmailAddress nvarchar(50),
	ModifiedDate datetime not null
);

with joined_data as 
	(
		select 
			[p].BusinessEntityID,
			[p].PersonType,
			[p].NameStyle,
			[p].FirstName,
			[p].MiddleName,
			[p].LastName,
			[p].Suffix,
			[p].EmailPromotion,
			[ea].EmailAddress,
			[p].ModifiedDate
			from [dbo].[Person] as p
		    join [Person].[EmailAddress] as ea 
			on (p.BusinessEntityId = ea.BusinessEntityID)
	)
insert into @tableVar
	(
		BusinessEntityId,
		PersonType,
		NameStyle,
		FirstName,
		MiddleName,
		LastName,
		Suffix,
		EmailPromotion,
		EmailAddress,
		ModifiedDate
	)
	select * from joined_data;

update dp
	set dp.EmailAddress = REPLACE(tv.EmailAddress, '0', '')
	from 
		[dbo].[Person] as dp
	join @tableVar as tv
		on dp.BusinessEntityId = tv.BusinessEntityId;

with ids as 
	(
		select pn.BusinessEntityID 
		from 
			[Person].[PersonPhone] as pn
			join [Person].[PhoneNumberType] as pnt
				on pn.PhoneNumberTypeID = pnt.PhoneNumberTypeID
				where pnt.Name = 'Work'
	)
delete dp 
from 
	[dbo].[Person] as dp
	where dp.BusinessEntityId in (select BusinessEntityID from ids);

ALTER TABLE dbo.Person DROP COLUMN EmailAddress;

DECLARE @database nvarchar(50)
DECLARE @table nvarchar(50)

set @database = N'[AdventureWorks2012]'
set @table = N'[dbo].[Person]'

DECLARE @sql nvarchar(255)
WHILE EXISTS(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				where CONSTRAINT_CATALOG = @database
				and TABLE_NAME = @table)
BEGIN
	select @sql = 'ALTER TABLE ' + @table + ' DROP CONSTRAINT ' + CONSTRAINT_NAME
	from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	where CONSTRAINT_CATALOG = @database 
	and TABLE_NAME = @table
	
	exec sp_executesql @sql
END

WHILE EXISTS (
	SELECT
		default_constraints.name
	FROM 
		sys.all_columns

        INNER JOIN
		sys.tables
        ON all_columns.object_id = tables.object_id

        INNER JOIN 
		sys.schemas
        ON tables.schema_id = schemas.schema_id

        INNER JOIN
		sys.default_constraints
        ON all_columns.default_object_id = default_constraints.object_id

		WHERE 
		schemas.name = 'dbo'
		AND tables.name = 'Person')
begin
	SELECT @sql = 'ALTER TABLE Person DROP CONSTRAINT ' + dc.name
	FROM 
		sys.all_columns

        INNER JOIN
		sys.tables
        ON all_columns.object_id = tables.object_id

        INNER JOIN 
		sys.schemas
        ON tables.schema_id = schemas.schema_id

        INNER JOIN
		sys.default_constraints as dc
        ON all_columns.default_object_id = dc.object_id

		WHERE 
		schemas.name = 'dbo'
		AND tables.name = 'Person'
	
	exec sp_executesql @sql
end

drop table [dbo].[Person]
		





