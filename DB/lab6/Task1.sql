use AdventureWorks2012;
go

create procedure HumanResources.GetGenderStat
	@columns nvarchar(1024)
as
	declare @sql nvarchar(2048)

	set @sql = N'select City, ' + @columns + '
	from 
	(
		select 
			e.Gender,
			e.BusinessEntityID,
			a.City
		from	
			HumanResources.Employee e
			join Person.BusinessEntityAddress bea on bea.BusinessEntityID = e.BusinessEntityID
			join Person.Address a on a.AddressID = bea.AddressID	
	) t
	pivot
	(
		count(BusinessEntityID)
		for Gender
			in (' + @columns + ')
	) pvt'

	execute sp_executesql @sql
go

EXECUTE HumanResources.GetGenderStat '[F],[M]'