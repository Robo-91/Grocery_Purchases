-- Views
create view v_LocInventory as
	select StoreName as [Store Name],
		   StoreState as [Store State],
		   ProductName as [Product Name],
		   Price from StoreInventory
		 join Products on StoreInventory.ProductId = Products.Id
		 join tbl_Locations on StoreInventory.LocationId = tbl_Locations.StoreId;


-- Procedures
alter procedure proc_StoreInventory
(
	@storeName varchar
)
as
begin
	select * from v_LocInventory
		where [Store Name] like concat(@storeName,'%')
		order by [Store State];
end

exec proc_StoreInventory @storeName = 'Wal';

alter procedure proc_AddProduct
(
	@product_id int,
	@name varchar(20),
	@price money
)
as
begin
	insert into Products(Id,ProductName,Price)
	values(@product_id,@name,@price);
end

exec proc_AddProduct @product_id = 760,@name='Reese''s',@price = 1.59;
