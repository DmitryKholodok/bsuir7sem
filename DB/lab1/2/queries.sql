SELECT [DepartmentID], [Name]
	FROM [AdventureWorks2012].[HumanResources].[Department]
	where [Name] like 'F%e'

SELECT 
	AVG([VacationHours]) as 'AvgVacationHours',
	AVG([SickLeaveHours]) as 'AvgSickLeaveHours'
	FROM [AdventureWorks2012].[HumanResources].[Employee]


select
	[BusinessEntityID],
	[JobTitle],
	[Gender],
	DATEDIFF(YY, [HireDate], GETDATE()) as [YearsWorked]
	from [AdventureWorks2012].[HumanResources].[Employee]
	where DATEDIFF(YY, [BirthDate], GETDATE()) > 65
