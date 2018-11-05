use AdventureWorks2012;
go 

create function Sales.GetLastCurrencyRate(@currencyCode nchar(3))
returns money
as
begin
	declare @value money

	select 
		@value = cr.EndOfDayRate
	from 
		Sales.CurrencyRate cr
	where 
		cr.ModifiedDate = (select max(cr.ModifiedDate) from Sales.CurrencyRate cr where cr.ToCurrencyCode = @currencyCode) and 
		cr.ToCurrencyCode = @currencyCode

	return @value;
end
go

SELECT 
	c.CurrencyCode, 
	Sales.GetLastCurrencyRate(c.CurrencyCode) as LastCurrencyRate 
FROM 
	Sales.Currency c
WHERE 
	c.CurrencyCode in ('EUR', 'SAR')
go


----------------------------------

create function Production.GetPurchaseOrderDetail(@productId int)
returns table
as
	return (
		select 
			*
		from 
			Purchasing.PurchaseOrderDetail d
		where 
			d.ProductID = @productId and
			d.OrderQty > 1000
	);
go

select 
	* 
from 
	Production.Product p
cross apply
	Production.GetPurchaseOrderDetail(p.ProductID)
go

select 
	* 
from 
	Production.Product p
outer apply
	Production.GetPurchaseOrderDetail(p.ProductID)
go


-----------------


create function Production.GetPurchaseOrderDetailMultistatement(@productId int)
returns @ResultTable table (ProductId int, PurchaseOrderId int, PurchaseOrderDetailId int, DueDate datetime, OrderQty smallint) 
as
begin
	insert into @ResultTable
	select 
		d.ProductID,
		d.PurchaseOrderID,
		d.PurchaseOrderDetailID,
		d.DueDate,
		d.OrderQty
	from 
		Purchasing.PurchaseOrderDetail d
	where 
		d.ProductID = @productId and
		d.OrderQty > 1000

	return;
end
go

select p.ProductID as IdFromProductTable, f.ProductId as IdFromFunction, f.OrderQty
from 
	Production.Product p
cross apply
	Production.GetPurchaseOrderDetailMultistatement(p.ProductID) f
go