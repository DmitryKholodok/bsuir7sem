use AdventureWorks2012;

create table dbo.Person (
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
		from [Person].[Person];

alter table dbo.Person add TotalGroupSales money, SalesYTD money, RoundSales as (FLOOR(SalesYTD));

create table #Person (
	BusinessEntityId int not null,
	PersonType nchar(2) not null,
	NameStyle bit not null,
	Title nvarchar(8),
	FirstName nvarchar(50) null,
	MiddleName nvarchar(50) null,
	LastName nvarchar(50) null,
	Suffix nvarchar(10),
	EmailPromotion int not null,
	ModifiedDate datetime not null,
	TotalGroupSales money,
	SalesYTD money,
	constraint PK_Person primary key (BusinessEntityId)
);

with group_and_total_sum as 
	(
		select  
			st.[Group] gr,
			SUM(st.SalesYTD) TotalGroupSum
			from 
				[Sales].[SalesTerritory] st
				group by st.[Group]
	)
insert into #Person
	(
		BusinessEntityId,
		PersonType,
		NameStyle,
		FirstName,
		MiddleName,
		LastName,
		Suffix,
		EmailPromotion,
		ModifiedDate,
		SalesYTD,
		TotalGroupSales
	)
	select
		[p].BusinessEntityID,
		[p].PersonType,
		[p].NameStyle,
		[p].FirstName,
		[p].MiddleName,
		[p].LastName,
		[p].Suffix,
		[p].EmailPromotion,
		[p].ModifiedDate ,
		[sp].SalesYTD,
		[ts].TotalGroupSum
		from 
			[dbo].[Person] p 
			join [Sales].[SalesPerson] sp on p.BusinessEntityId = sp.BusinessEntityID
			join [Sales].[SalesTerritory] st on st.TerritoryID = sp.TerritoryID
			join group_and_total_sum ts on ts.gr = st.[Group]
			
delete p from [dbo].[Person] p
	where p.EmailPromotion = 2;


MERGE 
	INTO [dbo].[Person] as trg
		USING #Person as src on trg.BusinessEntityId = src.BusinessEntityId
	WHEN MATCHED 
		THEN UPDATE 
		SET 
			trg.SalesYTD = src.SalesYTD,
			trg.TotalGroupSales = src.TotalGroupSales
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (
			BusinessEntityId,
			PersonType,
			NameStyle,
			FirstName,
			MiddleName,
			LastName,
			Suffix,
			EmailPromotion,
			ModifiedDate,
			SalesYTD,
			TotalGroupSales
		)
		values (
			BusinessEntityId,
			PersonType,
			NameStyle,
			FirstName,
			MiddleName,
			LastName,
			Suffix,
			EmailPromotion,
			ModifiedDate,
			SalesYTD,
			TotalGroupSales
		)
	WHEN NOT MATCHED BY SOURCE
		THEN DELETE;
