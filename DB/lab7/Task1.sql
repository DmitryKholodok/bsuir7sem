use AdventureWorks2012;

declare @xml as xml
set @xml = (
	select 
		cc.CreditCardID as '@ID',
		cc.CardType as '@Type',
		cc.CardNumber as '@Number'
	from 
		Sales.CreditCard cc
	for 
		xml path ('Card'), 
		root ('CreditCards')
)

EXEC Sales.GetCreditCardFields @xml

create procedure Sales.GetCreditCardFields
	@xml xml
as
	select 
		x.value('@ID', 'int') as Id,
		x.value('@Type', 'nvarchar(50)') as [Type],
		x.value('@Number', 'nvarchar(25)') as Number
	from 
		@xml.nodes('/CreditCards/Card') as X(x)
return
go

drop procedure Sales.GetCreditCardFields

