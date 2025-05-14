[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "orders_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "SalesOrderID", DestinationColumnName = "SalesOrderID"], [SourceColumnName = "OrderDate", DestinationColumnName = "OrderDate"], [SourceColumnName = "CustomerID", DestinationColumnName = "CustomerID"], [SourceColumnName = "LineItem", DestinationColumnName = "LineItem"], [SourceColumnName = "ProductID", DestinationColumnName = "ProductID"], [SourceColumnName = "OrderQty", DestinationColumnName = "OrderQty"], [SourceColumnName = "LineItemTotal", DestinationColumnName = "LineItemTotal"], [SourceColumnName = "MonthNo", DestinationColumnName = "MonthNo"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared orders = let
  Source = Csv.Document(Web.Contents("https://raw.githubusercontent.com/MicrosoftLearning/dp-data/main/orders.csv"), [Delimiter = ",", Columns = 7, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"SalesOrderID", Int64.Type}, {"OrderDate", type date}, {"CustomerID", Int64.Type}, {"LineItem", Int64.Type}, {"ProductID", Int64.Type}, {"OrderQty", Int64.Type}, {"LineItemTotal", type number}}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Changed column type", "MonthNo", each Date.Month([OrderDate])), {{"MonthNo", Int64.Type}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Added custom", {{"OrderDate", type date}})
in
  #"Changed column type 1";
shared DefaultDestination = Lakehouse.Contents(null){[workspaceId = "bcc55788-6c68-4dab-b0f9-69adebb9e4c4"]}[Data]{[lakehouseId = "93abf88c-fa6a-4352-a225-11585099f6c0"]}[Data];
shared orders_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "bcc55788-6c68-4dab-b0f9-69adebb9e4c4"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "93abf88c-fa6a-4352-a225-11585099f6c0"]}[Data],
  TableNavigation = Navigation_2{[Id = "orders", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
