CREATE TABLE [dbo].[FactSalesOrder] (

	[SalesOrderKey] int NOT NULL, 
	[SalesOrderDateKey] int NOT NULL, 
	[ProductKey] int NOT NULL, 
	[CustomerKey] int NOT NULL, 
	[Quantity] int NULL, 
	[SalesTotal] decimal(18,0) NULL
);


GO
ALTER TABLE [dbo].[FactSalesOrder] ADD CONSTRAINT FK_3e8e2b3d_8ce9_4dc1_870b_195372ec662e FOREIGN KEY ([SalesOrderDateKey]) REFERENCES [dbo].[DimDate]([DateKey]);
GO
ALTER TABLE [dbo].[FactSalesOrder] ADD CONSTRAINT FK_8943fc54_ce4d_4163_abcd_7e4b80de2141 FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer]([CustomerKey]);
GO
ALTER TABLE [dbo].[FactSalesOrder] ADD CONSTRAINT FK_9f076c02_3485_4b9c_81d8_a6d8d1bb9cf7 FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct]([ProductKey]);