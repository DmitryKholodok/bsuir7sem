use [AdventureWorks2012];

create table [dbo].[Person]
(
	BusinessEntityId int not null,
	PersonType nchar(2) not null,
	NameStyle dbo.NameStyle,
	Title nvarchar(8),
	FirstName dbo.Name not null,
	MiddleName dbo.Name,
	LastName dbo.Name not null,
	Suffix nvarchar(10),
	EmailPromotion int not null,
	ModifiedDate datetime not null
);

alter table [dbo].[Person]
add constraint PK_Person primary key (BusinessEntityId, PersonType);

alter table [dbo].[Person]
add constraint CK_Person_PersonType check (PersonType in ('GC', 'SP', 'EM', 'IN', 'VC', 'SC'));

alter table [dbo].[Person]
add constraint DF_Person_Title default 'n/a' for Title;

insert into [dbo].[Person]
	(
		BusinessEntityId,
		PersonType,
		NameStyle,
		FirstName,
		MiddleName,
		LastName,
		Suffix,
		EmailPromotion,
		ModifiedDate
	)
	select 
		[Person].BusinessEntityID,
		[Person].PersonType,
		[Person].NameStyle,
		[Person].FirstName,
		[Person].MiddleName,
		[Person].LastName,
		[Person].Suffix,
		[Person].EmailPromotion,
		[Person].ModifiedDate
		from [Person].[Person]
		inner join [Person].[BusinessEntityContact]
			on [Person].[Person].BusinessEntityID = [Person].[BusinessEntityContact].PersonID
		inner join [Person].[ContactType]
			on [Person].[ContactType].ContactTypeID = [Person].[BusinessEntityContact].ContactTypeID
		where [Person].[ContactType].Name = 'Owner'

alter table [dbo].[Person]
alter column Title nvarchar(4) not null;