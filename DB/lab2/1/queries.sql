use [AdventureWorks2012];
SELECT 
	[Department].Name,
	MIN([EmployeeDepartmentHistory].StartDate) as StartDate
	FROM [HumanResources].[EmployeeDepartmentHistory]
	INNER JOIN [HumanResources].[Department]
		ON [EmployeeDepartmentHistory].DepartmentID = [Department].DepartmentID
	group by [EmployeeDepartmentHistory].DepartmentID, [Department].Name

SELECT 
	[Employee].BusinessEntityID,
	[Employee].JobTitle,
	case [Shift].Name 
		when 'Day' then 1
		when 'Evening' then 2
		when 'Night' then 3
	end as ShiftName
	FROM [HumanResources].[Employee]
	INNER JOIN [HumanResources].[EmployeeDepartmentHistory]
		ON [EmployeeDepartmentHistory].BusinessEntityID = [Employee].BusinessEntityID
	INNER JOIN [HumanResources].[Shift]
		ON [Shift].ShiftID = [EmployeeDepartmentHistory].ShiftID
	where [Employee].JobTitle = 'Stocker'

SELECT 
	[Employee].BusinessEntityID,
	REPLACE([Employee].JobTitle, 'and', '&'),
	[Department].Name	
	FROM [HumanResources].[Employee]
	INNER JOIN [HumanResources].[EmployeeDepartmentHistory]
		ON [Employee].BusinessEntityID = [EmployeeDepartmentHistory].BusinessEntityID
	INNER JOIN [HumanResources].[Department]
		ON [EmployeeDepartmentHistory].DepartmentID = [Department].DepartmentID
	

