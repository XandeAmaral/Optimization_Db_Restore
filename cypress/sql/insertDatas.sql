SET QUOTED_IDENTIFIER ON

BEGIN TRANSACTION;

-- Variável para armazenar o BusinessEntityID gerado
DECLARE @BusinessEntityID INT;
DECLARE @Max INT = 1000;

-- Loop para inserir @Max registros
DECLARE @i INT = 1;
WHILE @i <= @Max
BEGIN
    -- Inserir um novo registro na tabela Person.BusinessEntity e obter o BusinessEntityID gerado
    INSERT INTO Person.BusinessEntity (rowguid)
    VALUES (NEWID());

    -- Obter o último BusinessEntityID inserido
    SET @BusinessEntityID = SCOPE_IDENTITY();

    -- Inserir um novo registro na tabela Person.Person usando o BusinessEntityID gerado
    INSERT INTO Person.Person
    (BusinessEntityID, FirstName, LastName, PersonType, NameStyle, EmailPromotion, rowguid, ModifiedDate)
    VALUES
    (@BusinessEntityID, CONCAT('FirstName', @i), CONCAT('LastName', @i), 'SC', 0, 0, NEWID(), GETDATE());

    -- Incrementar o contador
    SET @i = @i + 1;
END;

-- Confirmar as inserções
COMMIT;

-- Gerar @Max linhas na tabela HumanResources.Department
BEGIN TRANSACTION;
SET @i = 1;
WHILE @i <= @Max
BEGIN
    INSERT INTO HumanResources.Department
    (Name, GroupName)
    VALUES
    (CONCAT('FirstName', @i), CONCAT('LastName', @i));
    SET @i = @i + 1;
END;
COMMIT;

-- Gerar @Max linhas na tabela Production.Product
BEGIN TRANSACTION;
SET @i = 1;
WHILE @i <= @Max
BEGIN
    INSERT INTO Production.Product
    (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, rowguid, ModifiedDate)
    VALUES
    (CONCAT('Product', @i), CONCAT('PN-', @i), 1, 1, 'Black', 100, 50, 100.00, 150.00, 'M', 'CM', 'KG', 10.00, 5, 'T', 'H', 'U', 1, 1, GETDATE(), NEWID(), GETDATE());

    -- Incrementar o contador
    SET @i = @i + 1;
END;

-- Confirmar as inserções
COMMIT;


